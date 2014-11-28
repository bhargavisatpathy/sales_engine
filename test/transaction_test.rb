gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/transaction'


class TransactionTest < Minitest::Test
  attr_reader :parent
  def test_transaction_test_attributes
    data = {
      id: '1', invoice_id: '1',credit_card_number: '4654405418249632',
      credit_card_expiration_date: nil,
      result: 'success',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }

    @parent = Minitest::Mock.new
    transaction = Transaction.new(data,parent)

    assert_equal '1', transaction.id
    assert_equal '1', transaction.invoice_id
    assert_equal '4654405418249632', transaction.credit_card_number
    assert_equal nil, transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
    assert_equal '2012-03-27 14:54:09 UTC', transaction.created_at
    assert_equal '2012-03-27 14:54:09 UTC', transaction.updated_at
  end
end