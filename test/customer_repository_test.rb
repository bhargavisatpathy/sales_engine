gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository
  def setup
    @customer_repository = CustomerRepository.new
    customer_repository.load_file("./data/customers_testdata.csv")
  end

  def test_load_test_datafile
    assert_equal 18, customer_repository.find_all.length
  end

  def test_the_3rd_record_has_first_name_mariah

    assert_equal "Mariah", customer_repository.find_all[2].first_name
  end

  def test_the_10th_record_has_last_name_reynolds
    assert_equal "Reynolds", customer_repository.find_all[9].last_name
  end

  def test_find_all_by_last_name_will_returns_3_named_rodriguez
    assert_equal 3, customer_repository.find_all_by_last_name("Rodriguez").count
  end
end
