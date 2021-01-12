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
    collect_items_sold.each do |item|
      inside_hash = Hash.new(0)
      @food_trucks.each do |food_truck|
        inside_hash[:quantity] += food_truck.check_stock(item)
      end
      inside_hash[:food_trucks] = food_trucks_that_sell(item)
      item_hash[item] = inside_hash
    end
    item_hash
  end

  def overstocked_items
    
  end

end
