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
      quantity, name, price = default_csv_headers.map {|field| line[field].strip}
      receipt.add_item(Product.new(name: name, price: price), quantity)
    end
    receipt
  end

  def print_receipt(csv_content_input)
    receipt = parse(csv_content_input)
    output = CSV.generate do |csv|
      receipt.items.each do |receipt_item|
        csv << [receipt_item.quantity, " #{receipt_item.product.name}", " #{receipt_item.total_price}"]
      end
    end
    output << "\n"
    output << sprintf("Sales Taxes: %.2f\n", receipt.sales_taxes)
    output << sprintf("Total: %.2f", receipt.total_price)
    output
  end
end
