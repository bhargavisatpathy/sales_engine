gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repository
  def setup
    @invoice_repository = InvoiceRepository.load_file("./data/invoices_testdata.csv")
  end
  def test_load_test_datafile
    assert_equal 24, invoice_repository.find_all.length
  end

  def test_the_3rd_record_has_merchant_id_78
    assert_equal "78", invoice_repository.find_all[2].merchant_id
  end
end
