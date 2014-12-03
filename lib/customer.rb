require 'date'
class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :repository

  def initialize(row, repository)
    @id         = row[:id].to_i
    @first_name = row[:first_name]
    @last_name  = row[:last_name]
    @created_at = Date.parse(row[:created_at])
    @updated_at = Date.parse(row[:updated_at])
    @repository = repository
  end

  def invoices
    @invoices ||= repository.find_invoices(id)
  end
  def transactions
    invoices.reduce([]) { |trans, invoice| trans << invoice.transactions }
    #invoices.flat_map { |invoice| [invoice.transactions] }
  end

  def favorite_merchant
    merchant_invoices = invoices.select { |invoice| invoice.paid? }.group_by { |invoice| invoice.merchant }.to_a
    merchant_invoices.max_by { |pair| pair[1].length }[0]
  end

  def items_purchased
    @items_purchased ||= invoices.reduce(0) { |sum, invoice| sum + invoice.items_purchased }
  end

  def revenue
    @revenue ||= calculate_revenue
  end

  def calculate_revenue
    invoices.reduce(0) { |sum, invoice| sum + invoice.revenue }
  end

  def pending_invoices
    invoices.select { |invoice| invoice.failed? }
  end

  def clear_cache
    @revenue = nil
    @items_purchased = nil
    @invoices = nil
  end
end
