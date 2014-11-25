require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Item)
  end

  def find_by_name(name)
    find_by_X(:name, name)
  end
end
