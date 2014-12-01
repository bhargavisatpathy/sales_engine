gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/merchant'


class MerchantTest < Minitest::Test
  attr_reader :parent, :merchant

  def setup
    data = {
      id: '1', name: 'Schroeder-Jerde',
      created_at: '2012-03-27 14:54:00 UTC',
      updated_at: '2012-03-27 14:54:00 UTC'
    }

    @parent = Minitest::Mock.new
    @merchant = Merchant.new(data, parent)
  end

  def test_it_exists
    assert merchant
  end

  def test_merchant_test_attributes
    assert_equal '1', merchant.id
    assert_equal 'Schroeder-Jerde', merchant.name
    assert_equal '2012-03-27 14:54:00 UTC', merchant.created_at
    assert_equal '2012-03-27 14:54:00 UTC', merchant.updated_at
  end

  def test_it_delegates_items_to_its_repository
    parent.expect(:find_items, nil, ["1"])
    merchant.items
    parent.verify
  end

  def test_it_delegates_invoices_to_its_repository

    parent.expect(:find_invoices, nil, ["1"] )
    merchant.invoices
    parent.verify
  end
end