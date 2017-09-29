require "csv"
require "receipt-calculator/version"
require "receipt-calculator/product"
require "receipt-calculator/receipt"

module ReceiptCalculator
  extend self

  def parse(csv_input)
    receipt = Receipt.new
    lines = CSV.parse(csv_input, headers: true, header_converters: ->(h) {h.strip})
    lines = lines.map do |line|
      quantity, name, price = parse_line(line)
      receipt.add_item(
        Product.new(name: name, price: price),
        quantity
      )
    end
    receipt
  end

  def parse_line(line)
    default_csv_headers.map {|field| line[field].strip}
  end

  def print_receipt(csv_input)
    receipt = parse(csv_input)
    generate_receipt_body(receipt) + "\n" + generate_receipt_footer(receipt)
  end

  def generate_receipt_body(receipt)
    CSV.generate do |csv|
      receipt.items.each do |receipt_item|
        csv << [
          receipt_item.quantity,
          " #{receipt_item.product.name}",
          " #{receipt_item.total_price}"]
      end
    end
  end

  def generate_receipt_footer(receipt)
    output = ""
    output << sprintf("Sales Taxes: %.2f\n", receipt.sales_taxes)
    output << sprintf("Total: %.2f", receipt.total_price)
  end

  def default_csv_headers
    ['Quantity', 'Product', 'Price']
  end
end
