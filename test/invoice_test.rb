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

  def test_it_exists
    assert invoice
  end

  def test_invoice_has_attributes
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
    assert_equal 'shipped', invoice.status
    assert_equal Date.new(2012,3,25), invoice.created_at
    assert_equal Date.new(2012,3,25), invoice.updated_at
  end

  def test_invoice_is_paid
    paid_transaction = Transaction.new({result: 'success', created_at: '2012-03-25 09:54:09 UTC', updated_at: '2012-03-25 09:54:09 UTC'}, nil)
    unpaid_transaction = Transaction.new({result: 'failed', created_at: '2012-03-25 09:54:09 UTC', updated_at: '2012-03-25 09:54:09 UTC'}, nil)
    parent.expect(:find_transactions, [unpaid_transaction, paid_transaction], [1])
    assert invoice.paid?
    parent.verify
  end

  def test_it_delegates_transactions_to_its_repository
    parent.expect(:find_transactions, nil, [1])
    invoice.transactions
    parent.verify
  end

  def test_it_delegates_invoice_items_to_its_repository
    parent.expect(:find_invoice_items, nil, [1])
    invoice.invoice_items
    parent.verify
  end

  def test_it_delegates_items_to_its_repository
    parent.expect(:find_items, nil, [1])
    invoice.items
    parent.verify
  end

  def test_it_delegates_customer_to_its_repository
    parent.expect(:find_customer, nil, [1])
    invoice.customer
    parent.verify
  end

  def test_it_delegates_merchant_to_its_repository
    parent.expect(:find_merchant, nil, [26])
    invoice.merchant
    parent.verify
  end
end
