require 'csv'
require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository
  def load_file(filename)
    rows     = CSV.open(filename, headers: true, header_converters: :symbol)
    @entities = rows.map do |row|
      Merchant.new(row, self)
    end
  end

  def find_by_name(name)
    find_by_X(:name, name)
  end

  def find_all_by_name(name)
    find_all_by_X(:name, name)
  end
end
