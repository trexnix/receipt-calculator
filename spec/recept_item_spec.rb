require 'receipt-calculator/product'
require 'receipt-calculator/receipt_item'

RSpec.describe ReceiptCalculator::ReceptItem do
  before do
    @tax_calculator = double('TaxCalculator')
    allow(ReceiptCalculator::TaxCalculator).to receive(:new).and_return(@tax_calculator)
  end

  it "#sale_taxes returns sale taxes" do
    allow(@tax_calculator).to receive(:calculate_tax).and_return(12)
    line_item = {product: Product.new(name: "Test product", price: 10), quantity: 2}
    expect(ReceiptCalculator::ReceptItem.new(line_item).sale_taxes).to eq(12)
  end

  it "#total returns total price for the line item" do
    allow(@tax_calculator).to receive(:calculate_tax).and_return(12)
    line_item = {product: Product.new(name: "Test product", price: 10), quantity: 2}
    expect(ReceiptCalculator::ReceptItem.new(line_item).total).to eq(44)
  end

  it "#total should be round" do
    allow(@tax_calculator).to receive(:calculate_tax).and_return(1.9)
    line_item = {product: Product.new(name: "Test product", price: 18.99), quantity: 1}
    expect(ReceiptCalculator::ReceptItem.new(line_item).total).to eq(20.89)
  end
end