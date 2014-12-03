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
    repository.find_items(id)
  end

  def invoices
    @invoices ||= repository.find_invoices(id)
  end

  def revenue(date = nil)
    if date.nil?
      @revenue ||= calculate_revenue
    else
      calculate_revenue(date)
    end
  end

  def calculate_revenue(date = nil)
    if date.nil?
      invoices.reduce(0) { |sum, invoice| sum + invoice.revenue }
    else
      invoices.select { |invoice| invoice.updated_at == date }.reduce(0) { |sum, invoice| sum + invoice.revenue}
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
end
