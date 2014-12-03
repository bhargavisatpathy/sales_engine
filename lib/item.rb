require 'bigdecimal'
require 'date'

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :repository

  def initialize(row, repository)
    @id           = row[:id].to_i
    @name         = row[:name]
    @description  = row[:description]
    @unit_price   = BigDecimal(row[:unit_price])/100
    @merchant_id  = row[:merchant_id].to_i
    @created_at = Date.parse(row[:created_at])
    @updated_at = Date.parse(row[:updated_at])
    @repository   = repository
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def revenue
    @revenue ||= invoice_items.select { |invoice_item| invoice_item.invoice.paid? }
                              .reduce(0) { |sum, invoice_item| sum + invoice_item.total_price }
  end

  def quantity_sold
    @quantity_sold ||= invoice_items.select { |invoice_item| invoice_item.invoice.paid? }
                                    .reduce(0) { |sum, invoice_item| sum + invoice_item.quantity }
  end

  def best_day
    date_items = invoice_items.select { |invoice_item| invoice_item.invoice.paid? }
                 .group_by { |invoice_item| invoice_item.invoice.created_at }.to_a
    date_items.max_by { |pair| pair[1].reduce(0) { |sum, invoice_item| sum + invoice_item.quantity }}[0]
  end
end
