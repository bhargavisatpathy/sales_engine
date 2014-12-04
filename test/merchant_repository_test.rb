gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository, :sales_engine
  def setup
    @merchant_repository = MerchantRepository.new(nil, "./fixtures/merchants_testdata.csv")
    merchant_repository.load_file 
    @sales_engine = SalesEngine.new
  end
  def test_load_test_datafile
    assert_equal 20, merchant_repository.all.length
  end

  def test_the_3rd_record_has_name_Willms_and_Sons
    assert_equal "Willms and Sons", merchant_repository.all[2].name
  end

  def test_find_all_by_name
    assert_equal 2, merchant_repository.find_all_by_name("Williamson Group").count
  end

  def test_it_delegates_find_items_to_sales_engine
    parent = Minitest::Mock.new
    merchant_repository = MerchantRepository.new(parent, nil)
    parent.expect(:find_items_by_merchant, nil, [1])
    merchant_repository.find_items(1)
    parent.verify
  end

  def test_it_delegates_find_invoices_to_sales_engine
    parent = Minitest::Mock.new
    merchant_repository = MerchantRepository.new(parent, nil)
    parent.expect(:find_invoices_by_merchant, nil, [1])
    merchant_repository.find_invoices(1)
    parent.verify
  end

  def test_it_can_return_top_x_revenue
  skip
    most_rev = sales_engine.merchant_repository.most_revenue(1)

    puts "testing top rev"
    assert_equal "Dicki-Bednar", most_rev
    
    # parent = Minitest::Mock.new
    # merchant = Minitest::Mock.new
    # merchant_repository = MerchantRepository.new(parent, nil)
    # merchant.expect(:revenue, nil, [1])
    # merchant_repository.most_revenue(1)
    # merchant.verify
  end
end
