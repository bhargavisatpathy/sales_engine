require 'csv'
require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository
  def load_file
    rows     = CSV.open(filename, headers: true, header_converters: :symbol)
    @entities = rows.map do |row|
      InvoiceItem.new(row, self)
    end
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

  def find_invoice(invoice_id)
    sales_engine.find_invoice(invoice_id)
  end
  def find_item(item_id)
    sales_engine.find_item(item_id)
  end

  def create(input)
    new_row = InvoiceItem.new({id: next_id, item_id: input[:item].id, invoice_id: input[:invoice_id],
       quantity: input[:quantity], unit_price: input[:item].unit_price,
       created_at: Time.now.to_s, updated_at: Time.now.to_s}, self)
    @entities << new_row
    input[:item].clear_cache
    new_row
  end

  def inspect
    " #{self.class} #{@entities.size} "
  end
end
