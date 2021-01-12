require 'minitest/autorun'
require 'minitest/pride'
require './lib/food_truck'
require './lib/item'
require './lib/event'
require 'date'

class EventTest < Minitest::Test

  def setup
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
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

  def test_food_trucks_can_be_added
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    assert_equal [@food_truck1, @food_truck2, @food_truck3], @event.food_trucks
  end

  def test_we_can_retrieve_food_truck_names
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    assert_equal ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @event.food_truck_names
  end

  def test_event_can_show_foodtrucks_that_sell_specific_items
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    assert_equal [@food_truck1, @food_truck3], @event.food_trucks_that_sell(@item1)
    assert_equal [@food_truck2], @event.food_trucks_that_sell(@item4)
  end

  def test_potential_revenue_of_food_trucks_can_be_found
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    assert_equal 148.75, @food_truck1.potential_revenue
    assert_equal 345, @food_truck2.potential_revenue
    assert_equal 243.75, @food_truck3.potential_revenue

  end

  def test_food_truck_sorted_item_list
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item3, 10)
    assert_equal ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"], @event.sorted_item_list
  end

  def test_total_inventory_and_helpers
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item3, 10)
    expected = {@item1 => {quantity: 100,
                           food_trucks: [@food_truck1, @food_truck3]
                           },
                @item2 => {quantity: 7,
                           food_trucks: [@food_truck1]
                           },
                @item4 => {quantity: 50,
                           food_trucks: [@food_truck2]
                           },
                @item3 => {quantity:35,
                            food_trucks: [@food_truck2, @food_truck3]}
                }
    assert_equal [@item1, @item2, @item4, @item3], @event.collect_items_sold
    assert_equal expected, @event.total_inventory
  end

  def test_overstocked_items
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item3, 10)
    assert_equal [@item1], @event.overstocked_items
  end

  def test_we_can_give_events_dates
    ### can you show me how to make this stub
    # Date.stubs(:today).returns(Date.new(2020, 2,24))
    assert_equal "12/01/2021", @event.date

  end

  def test_it_can_sell_items
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item3, 10)
    item5 = Item.new({name: 'Onion Pie', price: '$25.00'})
    assert_equal false, @event.sell(@item1, 200)
    assert_equal false , @event.sell(item5, 1)
    assert_equal true, @event.sell(@item4, 5)
    assert_equal 45, @food_truck2.check_stock(@item4)
    assert_equal true, @event.sell(@item1, 40)
    assert_equal 
  end
end
