require 'receptionist/product'
require 'receptionist/recept_item'

RSpec.describe Receptionist::ReceptItem do
  before do
    tax_calculator = double('TaxCalculator')
    allow(tax_calculator).to receive(:calculate_tax).and_return(12)
    allow(Receptionist::TaxCalculator).to receive(:new).and_return(tax_calculator)
    @line_item = {product: Product.new(name: "Test product", price: 10), quantity: 2}
  end

  it "#sale_taxes returns sale taxes" do
    expect(Receptionist::ReceptItem.new(@line_item).sale_taxes).to eq(12)
  end

  it "#total returns total price for the line item" do
    expect(Receptionist::ReceptItem.new(@line_item).total).to eq(44)
  end
end