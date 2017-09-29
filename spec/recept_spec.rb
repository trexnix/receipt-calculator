require 'receptionist/product'
require 'receptionist/tax_calculator'
require 'receptionist/recept_item'
require 'receptionist/recept'

RSpec.describe Receptionist::Recept do
  before do
    tax_calculator = double('TaxCalculator')
    allow(tax_calculator).to receive(:calculate_tax).and_return(5)
    allow(Receptionist::TaxCalculator).to receive(:new).and_return(tax_calculator)
    @product1 = Product.new(name: "Test product 1", price: 10)
    @product2 = Product.new(name: "Test product 2", price: 15)
  end

  it "#add_item adds line item to the list" do
    recept = Receptionist::Recept.new
    expect {
      recept.add_item(@product1, 2)
    }.to change { recept.line_items.size }.by(1)
    expect {
      recept.add_item(@product2, 3)
    }.to change { recept.line_items.size }.by(1)
  end

  it "#sales_taxes returns total sales taxes" do
    recept = Receptionist::Recept.new
    recept.add_item(@product1, 2)
    recept.calculate
    expect(recept.sales_taxes).to eq(5)
    
    recept.add_item(@product2, 3)
    recept.calculate
    expect(recept.sales_taxes).to eq(10)
  end

  it "#total returns total price of the recept" do
    recept = Receptionist::Recept.new
    recept.add_item(@product1, 2)
    recept.calculate
    expect(recept.total).to eq(30)

    recept.add_item(@product2, 3)
    recept.calculate
    expect(recept.total).to eq(90)
  end
end