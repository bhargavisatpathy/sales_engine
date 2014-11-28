gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository, :sales_engine

  def setup
    @sales_engine = SalesEngine.new  
    @merchant_repository = MerchantRepository.new(sales_engine)
    merchant_repository.load_file("./fixtures/merchants_testdata.csv")
  end

  def test_find_all
    assert_equal 20, merchant_repository.find_all.length
  end

  def test_find_random
    assert merchant_repository.find_random
  end
end
