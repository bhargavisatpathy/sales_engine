require 'csv'
require_relative 'repository'
require_relative 'invoice'

class InvoiceRepository < Repository
  def load_file
    rows     = CSV.open(filename, headers: true, header_converters: :symbol)
    @entities = rows.map do |row|
      Invoice.new(row, self)
    end
  end

  def find_by_customer_id(customer_id)
    find_by_X(:customer_id, customer_id)
  end

  def find_by_merchant_id(merchant_id)
    find_by_X(:merchant_id, merchant_id)
  end

  def find_by_status(status)
    find_by_X(:status, status)
  end

  def find_all_by_customer_id(customer_id)
    find_all_by_X(:customer_id, customer_id)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by_X(:merchant_id, merchant_id)
  end

  def find_all_by_status(status)
    find_all_by_X(:status, status)
  end

  def find_transactions(id)
    sales_engine.find_transactions_by_invoice(id)
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_invoice(id)
  end

  def find_items(id)
    sales_engine.find_items_by_invoice(id)
  end

  def find_customer(customer_id)
    sales_engine.find_customer(customer_id)
  end

  def find_merchant(merchant_id)
    sales_engine.find_merchant(merchant_id)
  end

  def next_id
    return 1 if all.empty?
    all.max_by { |invoice| invoice.id }.id + 1
  end

  def create(input)
    invoice_id = next_id
    invoice.new(id: invoice_id, customer_id: input[:customer].id, merchant_id: input[:merchant].id,
    status: input[:status], created_at: Time.now.to_s, updated_at: Time.now.to_s)
    input[:items].group_by { |item| item.id }.to_a
  end

  def inspect
    " #{self.class} #{@entities.size} "
  end
end
