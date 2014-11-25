require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Merchant)
  end
end
