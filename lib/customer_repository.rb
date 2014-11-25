require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Customer)
  end
end
