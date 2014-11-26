require 'csv'
require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository
  def load_file(filename)
    rows     = CSV.open(filename, headers: true, header_converters: :symbol)
    @entities = rows.map do |row|
      Customer.new(row)
    end
  end

  def find_by_first_name(first_name)
    find_by_X(:first_name, first_name)
  end

  def find_by_last_name(last_name)
    find_by_X(:last_name, last_name)
  end

  def find_all_by_first_name(first_name)
    find_all_by_X(:first_name, first_name)
  end

  def find_all_by_last_name(last_name)
    find_all_by_X(:last_name, last_name)
  end

end
