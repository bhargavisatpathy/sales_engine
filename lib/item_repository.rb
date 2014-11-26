require 'csv'
require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository
  def load_file(filename)
    rows     = CSV.open(filename, headers: true, header_converters: :symbol)
    @entities = rows.map do |row|
      Item.new(row)
    end
  end

  def find_by_name(name)
    find_by_X(:name, name)
  end

  def find_by_description(unit_price)
    find_by_X(:unit_price, unit_price)
  end

  def find_by_merchant_id(merchant_id)
    find_by_X(:merchant_id, merchant_id)
  end

  def find_all_by_name(name)
    find_all_by_X(:name, name)
  end

  def find_all_by_description(unit_price)
    find_all_by_X(:unit_price, unit_price)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by_X(:merchant_id, merchant_id)
  end
end
