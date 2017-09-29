require 'receipt-calculator/product'
require 'receipt-calculator/receipt_item'

RSpec.describe ReceiptCalculator::ReceiptItem do
  before do
    @tax_calculator = double('TaxCalculator')
    allow(ReceiptCalculator::TaxCalculator).to receive(:new).and_return(@tax_calculator)
  end

  it "#sale_taxes returns sale taxes" do
    allow(@tax_calculator).to receive(:calculate_tax).and_return(12)
    product = Product.new(name: "Test product", price: 10)
    expect(ReceiptCalculator::ReceiptItem.new(product, 2).sale_taxes).to eq(12)
  end

  it "#total returns total price for the line item" do
    allow(@tax_calculator).to receive(:calculate_tax).and_return(12)
    product = Product.new(name: "Test product", price: 10)
    expect(ReceiptCalculator::ReceiptItem.new(product, 2).total_price).to eq(44)
  end

  it "#total should be round" do
    allow(@tax_calculator).to receive(:calculate_tax).and_return(1.9)
    product = Product.new(name: "Test product", price: 18.99)
    expect(ReceiptCalculator::ReceiptItem.new(product, 1).total_price).to eq(20.89)
  end
end