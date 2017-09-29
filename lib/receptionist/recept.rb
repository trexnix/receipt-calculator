module Receptionist
  class Recept
    attr_accessor :line_items, :line_items_details
  
    def initialize
      @line_items = []
    end

    def add_item(product, quantity)
      line_items << {product: product, quantity: quantity}
    end

    def calculate
      self.line_items_details = line_items.map do |line_item|
        ReceptItem.new(line_item).details
      end
    end

    def sales_taxes
      line_items_details
        .map {|item_details| item_details[:sale_taxes]}
        .inject(:+)
        # .round(2)
      
    end

    def total
      line_items_details
        .map {|item_details| item_details[:total]}
        .inject(:+)
        # .round(2)
    end
  end
end