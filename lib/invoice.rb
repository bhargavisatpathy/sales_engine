require 'date'
class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :repository

  def initialize(row, repository)
    @id          = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status      = row[:status]
    @created_at  = Date.parse(row[:created_at])
    @updated_at  = Date.parse(row[:updated_at])
    @repository  = repository
  end
  def transactions
    @transactions ||= repository.find_transactions(id)
  end
  def invoice_items
    @invoice_items ||= repository.find_invoice_items(id)
  end
  def items
    @item ||= repository.find_items(id)
  end
  def customer
    @customer ||= repository.find_customer(customer_id)
  end
  def merchant
    @merchant ||= repository.find_merchant(merchant_id)
  end
  def paid?
    @paid ||= transactions.any? {|transaction| transaction.result == "success"}
  end
  def revenue
      @revenue ||= calculate_revenue
  end

  def calculate_revenue
    return 0 unless paid?
    invoice_items.reduce(0) { |sum, invoice_item| sum + invoice_item.total_price }
  end

  def items_sold
    @item_sold ||= calculate_items_sold
  end

  def calculate_items_sold
    return 0 unless paid?
    invoice_items.reduce(0) { |sum, invoice_item| sum + invoice_item.quantity }
  end

  def charge(input)
    input[:invoice_id] = id
    repository.create_transaction(input)
  end

  def clear_cache
    @transactions = nil
  end
end
