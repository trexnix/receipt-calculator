class Product
  attr_accessor :name, :price

  def initialize(name: nil, price: nil)
    @name = name
    @price = price.to_f
  end
end