gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository#, :sales_engine
  def setup
    #@sales_engine = SalesEngine.new
    @customer_repository = CustomerRepository.new(nil, "./fixtures/customers_testdata.csv")
    customer_repository.load_file
  end

  def test_load_test_datafile
    assert_equal 18, customer_repository.all.length
  end

  def test_the_3rd_record_has_first_name_mariah
    assert_equal "Mariah", customer_repository.all[2].first_name
  end

  def test_the_10th_record_has_last_name_reynolds
    assert_equal "Reynolds", customer_repository.all[9].last_name
  end

  def test_find_all_by_last_name_will_return_3_named_rodriguez
    assert_equal 3, customer_repository.find_all_by_last_name("Rodriguez").count
  end

  def test_it_delegates_find_invoices_to_sales_engine
    parent = Minitest::Mock.new
    customer_repository = CustomerRepository.new(parent, nil)
    parent.expect(:find_invoices_by_customer, nil, ["1"])
    customer_repository.find_invoices("1")
    parent.verify
  end
end
