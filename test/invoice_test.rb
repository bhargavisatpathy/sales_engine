gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/invoice'
require_relative '../lib/transaction'


class InvoiceTest < Minitest::Test
  attr_reader :parent, :invoice
  def setup
    data = {
      id: '1', customer_id: '1',merchant_id: '26',
      status: 'shipped',
      created_at: '2012-03-25 09:54:09 UTC',
      updated_at: '2012-03-25 09:54:09 UTC'
    }

    @parent = Minitest::Mock.new
    @invoice = Invoice.new(data, parent)
  end

  def test_invoice_test_attributes
    assert_equal '1', invoice.id
    assert_equal '1', invoice.customer_id
    assert_equal '26', invoice.merchant_id
    assert_equal 'shipped', invoice.status
    assert_equal '2012-03-25 09:54:09 UTC', invoice.created_at
    assert_equal '2012-03-25 09:54:09 UTC', invoice.updated_at
  end

  def test_invoice_is_paid
    paid_transaction = Transaction.new({result: 'success'}, nil)
    unpaid_transaction = Transaction.new({result: 'failed'}, nil)
    parent.expect(:find_transactions, [unpaid_transaction, paid_transaction], ['1'])
    assert invoice.paid?
    parent.verify
  end
end
