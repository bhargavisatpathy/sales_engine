gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/invoice_item'


class InvoiceItemTest < Minitest::Test
  attr_reader :parent
  def test_Invoice_Item_attributes
    data = {
      id: '1', item_id: '539',invoice_id: '1',
      quantity: '5', unit_price: '13635',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }

    @parent = Minitest::Mock.new
    invoice_item = InvoiceItem.new(data, parent)

    assert_equal '1', invoice_item.id
    assert_equal '539', invoice_item.item_id
    assert_equal '1', invoice_item.invoice_id
    assert_equal '5', invoice_item.quantity
    assert_equal '13635', invoice_item.unit_price
    assert_equal '2012-03-27 14:54:09 UTC', invoice_item.created_at
    assert_equal '2012-03-27 14:54:09 UTC', invoice_item.updated_at
  end
end