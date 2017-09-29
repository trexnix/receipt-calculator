require 'receipt-calculator/product'
require 'receipt-calculator/tax_calculator'
require 'receipt-calculator/receipt_item'
require 'receipt-calculator/receipt'

RSpec.describe ReceiptCalculator::Receipt do
  before do
    tax_calculator = double('TaxCalculator')
    allow(tax_calculator).to receive(:calculate_tax).and_return(5)
    allow(ReceiptCalculator::TaxCalculator).to receive(:new).and_return(tax_calculator)
    @product1 = Product.new(name: "Test product 1", price: 10)
    @product2 = Product.new(name: "Test product 2", price: 15)
  end

  it "#add_item adds line item to the list" do
    receipt = ReceiptCalculator::Receipt.new
    expect {
      receipt.add_item(@product1, 2)
    }.to change { receipt.line_items.size }.by(1)
    expect {
      receipt.add_item(@product2, 3)
    }.to change { receipt.line_items.size }.by(1)
  end

  it "#sales_taxes returns total sales taxes" do
    receipt = ReceiptCalculator::Receipt.new
    receipt.add_item(@product1, 2)
    receipt.calculate
    expect(receipt.sales_taxes).to eq(5)
    
    receipt.add_item(@product2, 3)
    receipt.calculate
    expect(receipt.sales_taxes).to eq(10)
  end

  it "#total returns total price of the receipt" do
    receipt = ReceiptCalculator::Receipt.new
    receipt.add_item(@product1, 2)
    receipt.calculate
    expect(receipt.total).to eq(30)

    receipt.add_item(@product2, 3)
    receipt.calculate
    expect(receipt.total).to eq(90)
  end
end