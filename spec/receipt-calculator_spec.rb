RSpec.describe ReceiptCalculator do
  it "parses CSV input" do
    receipt = ReceiptCalculator.parse <<~EOS
      Quantity, Product, Price
      1, imported bottle of perfume, 27.99
      2, bottle of perfume, 18.99
      3, packet of headache pills, 9.75
      4, imported box of chocolates, 11.25
    EOS

    expect(receipt.receipt_items_details.size).to eq(4)
    expect(receipt.receipt_items_details[0][:product].name).to eq('imported bottle of perfume')
    expect(receipt.receipt_items_details[0][:quantity]).to eq(1)
    expect(receipt.receipt_items_details[3][:product].name).to eq('imported box of chocolates')
    expect(receipt.receipt_items_details[3][:quantity]).to eq(4)
  end

  it "prints out the receipt details" do
    output = ReceiptCalculator.print_recept <<~EOS
      Quantity, Product, Price
      1, imported bottle of perfume, 27.99
      1, bottle of perfume, 18.99
      1, packet of headache pills, 9.75
      1, imported box of chocolates, 11.25
    EOS

    expect(output).to include("32.19")
    expect(output).to include("20.89")
    expect(output).to include("9.75")
    expect(output).to include("11.85")
    expect(output).to match(/Sales Taxes: 6\.70$/)
    expect(output).to match(/Total: 74\.68$/)
  end
end
