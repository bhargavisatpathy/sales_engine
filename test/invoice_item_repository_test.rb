gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository
  def setup
    @invoice_item_repository = InvoiceItemRepository.load_file("./data/invoice_items_testdata.csv")
  end
  def test_load_test_datafile
    assert_equal 22, invoice_item_repository.find_all.length
  end

  def test_the_3rd_record_has_item_id_523
    assert_equal "523", invoice_item_repository.find_all[2].item_id
  end
end
