gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/repository'

class MerchantRepositoryTest < Minitest::Test

  def test_load_file_Customer
    assert_equal 20, merchant_repository.find_all.length
  end

  def test_the_3rd_record_has_name_Willms_and_Sons
    assert_equal "Willms and Sons", merchant_repository.find_all[2].name
  end
end
