require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Merchant)
  end

  def find_by_name(name)
    find_by_X(:name, name)
  end

  def find_all_by_name(name)
    find_all_by_X(:name, name)
  end
end
