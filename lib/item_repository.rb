require 'csv'
require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository
  def load_file
    rows     = CSV.open(filename, headers: true, header_converters: :symbol)
    @entities = rows.map do |row|
      Item.new(row, self)
    end
  end

  def find_by_name(name)
    find_by_X(:name, name)
  end

  def find_by_description(description)
    find_by_X(:description, description)
  end

  def find_by_unit_price(unit_price)
    find_by_X(:unit_price, unit_price)
  end

  def find_by_merchant_id(merchant_id)
    find_by_X(:merchant_id, merchant_id)
  end

  def find_all_by_name(name)
    find_all_by_X(:name, name)
  end

  def find_all_by_description(description)
    find_all_by_X(:description, description)
  end

  def find_all_by_unit_price(unit_price)
    find_all_by_X(:unit_price, unit_price)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by_X(:merchant_id, merchant_id)
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_item(id)
  end
  def find_merchant(merchant_id)
    sales_engine.find_merchant(merchant_id)
  end
  def inspect
    " #{self.class} #{@entities.size} "
  end
  def most_revenue(x)

  end
  def most_items(x)

  end
end
