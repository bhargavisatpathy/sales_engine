require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, InvoiceItem)
  end

  def find_by_item_id(item_id)
    find_by_X(:item_id, item_id)
  end

  def find_by_invoice_id(invoice_id)
    find_by_X(:invoice_id, invoice_id)
  end

  def find_by_quantity(quantity)
    find_by_X(:quantity, quantity)
  end

  def find_by_unit_price(unit_price)
    find_by_X(:unit_price, unit_price)
  end

#find all by tests
  def find_all_by_item_id(item_id)
    find_all_by_X(:item_id, item_id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by_X(:invoice_id, invoice_id)
  end

  def find_all_by_quantity(quantity)
    find_all_by_X(:quantity, quantity)
  end

  def find_all_by_unit_price(unit_price)
    find_all_by_X(:unit_price, unit_price)
  end
end
