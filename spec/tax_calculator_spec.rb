require 'receipt-calculator/product'
require 'receipt-calculator/tax_calculator'

RSpec.describe ReceiptCalculator::TaxCalculator do
  before do
    @tax_calculator = ReceiptCalculator::TaxCalculator.new
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
    allow(@tax_calculator).to receive(:get_tax_rate_by_product).and_return(0.1)
    product1 = Product.new(price: 47.5)
    expect(@tax_calculator.calculate_tax(product1)).to eq(4.75)

    product2 = Product.new(price: 11.25)
    expect(@tax_calculator.calculate_tax(product2)).to eq(1.15)

    product3 = Product.new(price: 18.99)
    expect(@tax_calculator.calculate_tax(product3)).to eq(1.9)

    product4 = Product.new(price: 12.2)
    expect(@tax_calculator.calculate_tax(product4)).to eq(1.25)
  end
end