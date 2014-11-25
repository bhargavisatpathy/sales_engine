require_relative 'repository'
require_relative 'invoice'


class InvoiceRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Invoice)
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
end
