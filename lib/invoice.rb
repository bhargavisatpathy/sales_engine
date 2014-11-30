class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(row, repository)
    @id          = row[:id]
    @customer_id = row[:customer_id]
    @merchant_id = row[:merchant_id]
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
end
