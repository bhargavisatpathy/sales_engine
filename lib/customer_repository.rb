require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Customer)
  end

  def find_by_first_name(first_name)
    find_by_X(:first_name, first_name)
  end
end
