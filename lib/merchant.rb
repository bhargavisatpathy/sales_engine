require 'date'
class Merchant
  attr_reader :id, :name, :created_at, :updated_at, :repository

  def initialize(row, repository)
    @id           = row[:id].to_i
    @name         = row[:name]
    @created_at   = Date.parse(row[:created_at])
    @updated_at   = Date.parse(row[:updated_at])
    @repository   = repository
  end

  def items
    @items ||= repository.find_items(id)
  end

  def invoices
    @invoices ||= repository.find_invoices(id)
  end

  def revenue(criteria = nil)
    if criteria.nil?
      @revenue ||= calculate_revenue
    else
      calculate_revenue(criteria)
    end
  end

  def calculate_revenue(criteria = nil)
    if criteria.nil?
      invoices.reduce(0) { |sum, invoice| sum + invoice.revenue }
    else
      if criteria.class == Range
        invoices.select { |invoice| criteria.include?(invoice.created_at) }.reduce(0) { |sum, invoice| sum + invoice.revenue}
      else
        invoices.select { |invoice| invoice.created_at == criteria }.reduce(0) { |sum, invoice| sum + invoice.revenue}
      end
    end
  end

  def items_sold
    @items_sold ||= invoices.reduce(0) { |sum, invoice| sum + invoice.items_sold }
  end

  def favorite_customer
    customer_invoices = invoices.select { |invoice| invoice.paid? }.group_by { |invoice| invoice.customer }.to_a
    customer_invoices.max_by { |pair| pair[1].length }[0]
  end

  def customers_with_pending_invoices
    invoices.select { |invoice| !invoice.paid? }.group_by { |invoice| invoice.customer }.keys
  end

  def clear_cache
    @invoices = nil
    @items_sold = nil
    @revenue = nil
    @items = nil
  end
end
