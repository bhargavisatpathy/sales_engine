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
  def clear_cache
    @invoices = nil
  end
end
