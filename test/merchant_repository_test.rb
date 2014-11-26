gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository
  def setup
    @merchant_repository = MerchantRepository.load_file("./data/merchants_testdata.csv")
  end
  def test_load_test_datafile
    assert_equal 20, merchant_repository.find_all.length
  end

  def test_the_3rd_record_has_name_Willms_and_Sons
    assert_equal "Willms and Sons", merchant_repository.find_all[2].name
  end

  def test_find_all_by_name
    assert_equal 2, merchant_repository.find_all_by_name("Williamson Group").count
  end
end
