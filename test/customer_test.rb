gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/customer'


class CustomerTest < Minitest::Test
  attr_reader :parent
  def test_customer_test_attributes
    data = {
      id: '1', first_name: 'Joey',last_name: 'Ondricka',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }

    @parent = Minitest::Mock.new
    customer = Customer.new(data, parent)

    assert_equal '1', customer.id
    assert_equal 'Joey', customer.first_name
    assert_equal 'Ondricka', customer.last_name
    assert_equal '2012-03-27 14:54:09 UTC', customer.created_at
    assert_equal '2012-03-27 14:54:09 UTC', customer.updated_at
  end
end
