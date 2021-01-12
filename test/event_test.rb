require 'minitest/autorun'
require 'minitest/pride'
require './lib/foodtruck'
require './lib/item'
require './lib/event'

class EventTest < Minitest::Test

  def setup
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Event, @event
    assert_equal "South Pearl Street Farmers Market",@event.name
    assert_equal [], @event.food_trucks
  end

  def test_case_name

  end
end
