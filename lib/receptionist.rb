require "csv"
require "receptionist/version"
require "receptionist/product"
require "receptionist/recept"

module Receptionist
  extend self

  def default_csv_headers
    ['Quantity', 'Product', 'Price']
  end

  def parse(csv_content_input)
    recept = Recept.new
    lines = CSV.parse(csv_content_input, headers: true, header_converters: ->(h) {h.strip})
    lines.each do |line|
      quantity, name, price = default_csv_headers.map {|header_field| line[header_field].strip}
      recept.add_item(Product.new(name: name, price: price.to_f), quantity.to_i)
    end
    recept
  end

  def print_recept(csv_content_input)
    recept = parse(csv_content_input)
    recept.calculate
    output = CSV.generate do |csv|
      recept.line_items_details.each do |line_item_detail|
        csv << [line_item_detail[:quantity], line_item_detail[:product].name, line_item_detail[:total]]
      end
    end
    output << "\n"
    output << sprintf("Sales Taxes: %.2f\n", recept.sales_taxes)
    output << sprintf("Total: %.2f", recept.total)
    output
  end
end
