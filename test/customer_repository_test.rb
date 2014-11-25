gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository
  def setup
    @customer_repository = CustomerRepository.load_file("./data/customers_testdata.csv")
  end
  def test_load_test_datafile
    #customer_repository = CustomerRepository.load_file("./data/customers_testdata.csv")
    assert_equal 15, customer_repository.find_all.length
  end

  def test_the_3rd_record_has_first_name_mariah
    assert_equal "Mariah", customer_repository.find_all[2].first_name
  end
end
