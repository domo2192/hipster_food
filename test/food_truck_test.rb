require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'
class FoodTruckTest < Minitest::Test

  def setup
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of FoodTruck, @food_truck
    assert_equal "Rocky Mountain Pies", @food_truck.name
    assert_instance_of Hash, @food_truck.inventory
  end

  def test_check_stock_starts_at_0
    assert_equal 0, @food_truck.check_stock(@item1)
  end

  def test_check_items_can_be_stocked
    @food_truck.stock(@item1, 30)
    assert_equal 30, @food_truck.check_stock(@item1)
    expected = {@item1 => 30}
    assert_equal expected, @food_truck.inventory
    @food_truck.stock(@item1, 25)
    assert_equal 55, @food_truck.check_stock(@item1)
    @food_truck.stock(@item2, 12)
    expected = {@item1 => 55,
                @item2 => 12}
    assert_equal expected, @food_truck.inventory 
  end
end
