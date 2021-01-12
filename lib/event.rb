require 'date'
class Event
  attr_reader :name, :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |food_truck|
      food_truck.inventory.include?(item)
    end
  end

  def sorted_item_list
    sorted_names = []
    @food_trucks.each do |food_truck|
      food_truck.inventory.sort_by do |item, amount|
        sorted_names << item.name
      end
    end
    sorted_names.sort.uniq
  end

  def collect_items_sold
    @food_trucks.map do |truck|
      truck.inventory.map do |item, amount|
        item
      end
    end.flatten.uniq
  end

  def total_inventory
    item_hash = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, amount|
        if item_hash[item]
          item_hash[item][:quantity] += amount if item_hash[item]
        else
          item_hash[item] = {quantity: amount,
                             food_trucks: food_trucks_that_sell(item)}
        end
      end
    end
    item_hash
  end

  def overstocked_items
    total_inventory.select do |item, inside_hash|
      inside_hash[:quantity] > 50 && inside_hash[:food_trucks].count > 1
    end.keys
  end

  def date
    Date.today.strftime('%d/%m/%Y')
  end
end
