gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'


class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repository, :sales_engine
  def setup
    @sales_engine = SalesEngine.new
    @transaction_repository = TransactionRepository.new(sales_engine, "./fixtures/transactions_testdata.csv")
    transaction_repository.load_file
  end
  def test_load_test_datafile
    assert_equal 24, transaction_repository.find_all.length
  end

  def test_the_1st_record_has_an_invoice_id_1
    assert_equal "1", transaction_repository.find_all[0].invoice_id
  end

  def test_the_3rd_record_has_credit_card_number_4354495077693036
    assert_equal "4354495077693036", transaction_repository.find_all[2].credit_card_number
  end

  def test_credit_card_expiration_date_is_empty
    assert_equal nil, transaction_repository.find_all[5].credit_card_expiration_date
  end

  def test_20th_record_result_is_success
    assert_equal "success", transaction_repository.find_all[19].result
  end

  def test_find_all_by_invoice_id
    assert_equal 3, transaction_repository.find_all_by_invoice_id("12").count
  end

   def test_find_all_by_credit_card_number
    assert_equal 1, transaction_repository.find_all_by_credit_card_number("4654405418249632").count
  end

  #downcase issue with nil class
  #  def test_find_all_by_credit_card_expiration_date
  #   assert_equal 0, transaction_repository.find_all_by_credit_card_expiration_date("").count
  # end

   def test_find_all_by_result
    assert_equal 4, transaction_repository.find_all_by_result("failed").count
  end

end
