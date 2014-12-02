gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repository, :sales_engine
  def setup
    @sales_engine = SalesEngine.new
    @invoice_repository = InvoiceRepository.new(sales_engine, "./fixtures/invoices_testdata.csv")
    invoice_repository.load_file
  end

  def test_load_test_datafile
    assert_equal 24, invoice_repository.find_all.length
  end

  def test_the_1st_record_has_customer_id_
    assert_equal "1", invoice_repository.find_all[0].customer_id
  end

  def test_the_3rd_record_has_merchant_id_78
    assert_equal "78", invoice_repository.find_all[2].merchant_id
  end

  def test_the_10th_record_has_status_shipped
    assert_equal "shipped", invoice_repository.find_all[11].status
  end

  def test_find_all_by_customer_id
    assert_equal  8, invoice_repository.find_all_by_customer_id("1").count
  end

  def test_find_all_by_merchant_id
    assert_equal 2, invoice_repository.find_all_by_merchant_id("27").count
  end

  def test_find_all_by_status
    assert_equal 24, invoice_repository.find_all_by_status("shipped").count
  end

  def test_it_delegates_find_transactions_to_sales_engine
    parent = Minitest::Mock.new
    invoice_repository = InvoiceRepository.new(parent, nil)
    parent.expect(:find_transactions_by_invoice, nil, ["1"])
    invoice_repository.find_transactions("1")
    parent.verify
  end

  def test_it_delegates_find_invoice_items_to_sales_engine
    parent = Minitest::Mock.new
    invoice_repository = InvoiceRepository.new(parent, nil)
    parent.expect(:find_invoice_items_by_invoice, nil, ["1"])
    invoice_repository.find_invoice_items("1")
    parent.verify
  end

  def test_it_delegates_find_items_to_sales_engine
    parent = Minitest::Mock.new
    invoice_repository = InvoiceRepository.new(parent, nil)
    parent.expect(:find_items_by_invoice, nil, ["1"])
    invoice_repository.find_items("1")
    parent.verify
  end

  def test_it_delegates_find_customer_id_to_sales_engine
    parent = Minitest::Mock.new
    invoice_repository = InvoiceRepository.new(parent, nil)
    parent.expect(:find_customer, nil, ["1"])
    invoice_repository.find_customer("1")
    parent.verify
  end

  def test_it_delegates_find_merchant_id_to_sales_engine
    parent = Minitest::Mock.new
    invoice_repository = InvoiceRepository.new(parent, nil)
    parent.expect(:find_merchant, nil, ["1"])
    invoice_repository.find_merchant("1")
    parent.verify
  end
end
