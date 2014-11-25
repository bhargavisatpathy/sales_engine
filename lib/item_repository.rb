require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Item)
  end
end
