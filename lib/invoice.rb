class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :repository

  def initialize(row, repository)
    @id          = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status      = row[:status]
    @created_at  = row[:created_at]
    @updated_at  = row[:updated_at]
    @repository  = repository
  end
  def transactions
    repository.find_transactions(id)
  end
  def invoice_items
    repository.find_invoice_items(id)
  end
  def items
    repository.find_items(id)
  end
  def customer
    repository.find_customer(customer_id)
  end
  def merchant
    repository.find_merchant(merchant_id)
  end
  def paid?
    transactions.any? {|transaction| transaction.result == "success"}
  end
  def revenue
    revenue = 0
    if paid?
      revenue = invoice_items.reduce(0) { |sum, invoice_item| sum + (invoice_item.quantity * invoice_item.unit_price)}
    end
    revenue
  end
end
