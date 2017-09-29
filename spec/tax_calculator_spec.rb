require 'receptionist/product'
require 'receptionist/tax_calculator'

RSpec.describe Receptionist::TaxCalculator do
  before do
    @tax_calculator = Receptionist::TaxCalculator.new
  end
  it "domestic books, food, mediacal products should be exampt" do
    book = Product.new(name: "book", price: 20)
    food = Product.new(name: "chocolate bar", price: 10)
    medicine = Product.new(name: "packet of headache pills", price: 5)

    expect(@tax_calculator.calculate_tax(book)).to eq(0)
    expect(@tax_calculator.calculate_tax(book)).to eq(0)
    expect(@tax_calculator.calculate_tax(book)).to eq(0)
  end

  it "imported books, food, medical products should be taxed" do
    food = Product.new(name: "imported box of chocolates", price: 10)
    expect(@tax_calculator.calculate_tax(food)).to eq(0.5)
  end

  it "imported products other than books, food, medical should be taxed with both basic and imported tax" do
    perfume = Product.new(name: "imported bottle of perfume", price: 100)
    expect(@tax_calculator.calculate_tax(perfume)).to eq(15)
  end

  it "tax should be rounded up to nearest decimal" do
    perfume1 = Product.new(name: "imported bottle of perfume", price: 47.5)
    expect(@tax_calculator.calculate_tax(perfume1)).to eq(7.15)

    perfume2 = Product.new(name: "bottle of perfume", price: 18.99)
    expect(@tax_calculator.calculate_tax(perfume2)).to eq(1.9)
  end
end