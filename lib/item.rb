class Item
  attr_reader:name,
             :price
  def initialize(data)
    @name = data[:name]
    @string_price = data[:price]
  end

  def price
    @string_price.delete("$").to_f
  end
end
