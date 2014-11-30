gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine                         = SalesEngine.new
    sales_engine.merchant_repository      = Minitest::Mock.new
    sales_engine.invoice_repository       = Minitest::Mock.new
    sales_engine.item_repository          = Minitest::Mock.new
    sales_engine.invoice_item_repository  = Minitest::Mock.new
    sales_engine.customer_repository      = Minitest::Mock.new
    sales_engine.transaction_repository   = Minitest::Mock.new
  end
  def test_it_instantiates_repositories
    sales_engine = SalesEngine.new
    assert sales_engine.merchant_repository
    assert sales_engine.invoice_repository
    assert sales_engine.item_repository
    assert sales_engine.invoice_item_repository
    assert sales_engine.customer_repository
    assert sales_engine.transaction_repository
  end
  def test_it_delegates_startup_to_repository_load_files
    sales_engine.merchant_repository.expect(:load_file, nil, ["./data/merchants.csv"])
    sales_engine.invoice_repository.expect(:load_file, nil, ["./data/invoices.csv"])
    sales_engine.item_repository.expect(:load_file, nil, ["./data/items.csv"])
    sales_engine.invoice_item_repository.expect(:load_file, nil, ["./data/invoice_items.csv"])
    sales_engine.customer_repository.expect(:load_file, nil, ["./data/customers.csv"])
    sales_engine.transaction_repository.expect(:load_file, nil, ["./data/transactions.csv"])
    sales_engine.startup
    sales_engine.merchant_repository.verify
    sales_engine.invoice_repository.verify
    sales_engine.item_repository.verify
    sales_engine.invoice_item_repository.verify
    sales_engine.customer_repository.verify
    sales_engine.transaction_repository.verify
  end
  def test_it_delegates_find_invoices_by_customer_to_invoice_repository
    sales_engine.invoice_repository.expect(:find_all_by_customer_id, nil, ['1'])
    sales_engine.find_invoices_by_customer('1')
    sales_engine.invoice_repository.verify
  end
end
