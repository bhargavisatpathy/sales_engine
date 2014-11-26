require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Item)
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


#find by all

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
end
