class Product
  attr_accessor :name, :price

  def initialize(name:, price:)
    @name = name
    @price = price.to_f
  end
end