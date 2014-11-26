gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repository
  def setup
    @transaction_repository = TransactionRepository.new
    transaction_repository.load_file("./data/transactions_testdata.csv")
  end
  def test_load_test_datafile
    assert_equal 24, transaction_repository.find_all.length
  end

  def test_the_3rd_record_has_credit_card_number_4354495077693036
    assert_equal "4354495077693036", transaction_repository.find_all[2].credit_card_number
  end
end
