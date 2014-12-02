gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository, :sales_engine
  def setup
    @sales_engine = SalesEngine.new
    @invoice_item_repository = InvoiceItemRepository.new(sales_engine, "./fixtures/invoice_items_testdata.csv")
    invoice_item_repository.load_file
  end

  def test_load_test_datafile
    assert_equal 22, invoice_item_repository.find_all.length
  end

  def test_the_3rd_record_has_item_id_523
    assert_equal "523", invoice_item_repository.find_all[2].item_id
  end

  def test_find_by_invoice_id_has_invoice_id_1
    assert_equal "1", invoice_item_repository.find_all[2].invoice_id
  end

  def test_find_by_item_id
    assert_equal "535", invoice_item_repository.find_all[3].item_id
  end

  def test_find_by_quantity_has_quantity_5
    assert_equal "8", invoice_item_repository.find_all[2].quantity
  end

  def test_find_by_unit_price_has_value_of_34873
    assert_equal "34873", invoice_item_repository.find_all[2].unit_price
  end

  def test_find_all_by_item_id
    assert_equal 2, invoice_item_repository.find_all_by_item_id("1921").count
  end

  def test_find_all_by_invoice_id
    assert_equal 8, invoice_item_repository.find_all_by_invoice_id("1").count
  end

  def test_find_all_by_quantity
    assert_equal 3, invoice_item_repository.find_all_by_quantity("3").count
  end

  def test_find_all_by_unit_price
    assert_equal 3, invoice_item_repository.find_all_by_unit_price("72018").count
  end

  def test_it_delegates_find_invoices_to_sales_engine
    parent = Minitest::Mock.new
    invoice_item_repository = InvoiceItemRepository.new(parent, nil)
    parent.expect(:find_invoice, nil, ["1"])
    invoice_item_repository.find_invoice("1")
    parent.verify
  end

   def test_it_delegates_find_items_to_sales_engine
    parent = Minitest::Mock.new
    invoice_item_repository = InvoiceItemRepository.new(parent, nil)
    parent.expect(:find_item, nil, ["1"])
    invoice_item_repository.find_item("1")
    parent.verify
  end
end
