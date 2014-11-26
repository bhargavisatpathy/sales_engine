gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository
  def setup
    @item_repository = ItemRepository.load_file("./data/items_testdata.csv")
  end

  def test_load_test_datafile
    assert_equal 19, item_repository.find_all.length
  end

  def test_the_1st_record_has_name_Item_Qui_Esse
    assert_equal "Item Qui Esse", item_repository.find_all[0].name
  end

  def test_the_1st_description_is_Nihil
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", item_repository.find_all[0].description
  end 

  def test_the_3rd_unit_price_is_32301
    assert_equal "32301", item_repository.find_all[2].unit_price
  end

  def test_the_4th_merchant_id_is
    assert_equal "1", item_repository.find_all[3].merchant_id
  end

  def test_find_all_by_name
    assert_equal 1, item_repository.find_all_by_name("Item Expedita Aliquam").count
    # assert_equal 3, invoice_item_repository.find_all_by_unit_price("72018").count
  end

  def test_find_all_by_description
    assert_equal 1, item_repository.find_all_by_description("Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet.").count
  end

  def test_find_all_by_unit_price
    assert_equal 1, item_repository.find_all_by_unit_price("59454").count
  end

  def test_find_all_by_merchant_id
    assert_equal 4, item_repository.find_all_by_merchant_id("2").count
  end


end
