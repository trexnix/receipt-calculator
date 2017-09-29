require "receipt-calculator/receipt_item"

module ReceiptCalculator
  class Receipt
    attr_accessor :items
  
    def initialize
      @items = []
    end

    def add_item(product, quantity)
      items << ReceiptItem.new(product, quantity)
    end

    def sales_taxes
      items.map {|receipt_item| receipt_item.sale_taxes}.inject(:+)
    end

    def total_price
      items.map {|receipt_item| receipt_item.total_price}.inject(:+)
    end
  end
end