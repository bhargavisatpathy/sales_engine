gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository
  def setup
    @item_repository = ItemRepository.new
    item_repository.load_file("./data/items_testdata.csv")
  end
  def test_load_test_datafile
    assert_equal 19, item_repository.find_all.length
  end

  def test_the_1st_record_has_name_Item_Qui_Esse
    assert_equal "Item Qui Esse", item_repository.find_all[0].name
  end
end
