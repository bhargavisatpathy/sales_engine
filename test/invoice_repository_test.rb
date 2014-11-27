gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repository
  def setup
    @invoice_repository = InvoiceRepository.new
    invoice_repository.load_file("./data/invoices_testdata.csv")
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

end
