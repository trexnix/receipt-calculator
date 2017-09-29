require "csv"
require "receipt-calculator/version"
require "receipt-calculator/product"
require "receipt-calculator/receipt"

module ReceiptCalculator
  extend self

  def default_csv_headers
    ['Quantity', 'Product', 'Price']
  end

  def parse(csv_content_input)
    receipt = Receipt.new
    lines = CSV.parse(csv_content_input, headers: true, header_converters: ->(h) {h.strip})
    lines.each do |line|
      quantity, name, price = default_csv_headers.map {|header_field| line[header_field].strip}
      receipt.add_item(Product.new(name: name, price: price.to_f), quantity.to_i)
    end
    receipt
  end

  def print_recept(csv_content_input)
    receipt = parse(csv_content_input)
    receipt.calculate
    output = CSV.generate do |csv|
      receipt.line_items_details.each do |line_item_detail|
        csv << [line_item_detail[:quantity], " #{line_item_detail[:product].name}", " #{line_item_detail[:total]}"]
      end
    end
    output << "\n"
    output << sprintf("Sales Taxes: %.2f\n", receipt.sales_taxes)
    output << sprintf("Total: %.2f", receipt.total)
    output
  end
end
