require "receipt-calculator/receipt_item"

module ReceiptCalculator
  class Receipt
    attr_accessor :receipt_items
  
    def initialize
      @receipt_items = []
    end

    def add_item(product, quantity)
      receipt_items << ReceiptItem.new(product, quantity)
    end

    def receipt_items_details
      receipt_items.map do |receipt_item|
        receipt_item.details
      end
    end

    def sales_taxes
      receipt_items_details
        .map {|item_details| item_details[:sale_taxes]}
        .inject(:+)
    end

    def total
      receipt_items_details
        .map {|item_details| item_details[:total]}
        .inject(:+)
    end
  end
end