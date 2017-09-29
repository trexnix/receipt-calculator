require 'receipt-calculator/tax_calculator'

module ReceiptCalculator
  class ReceiptItem
    attr_accessor :tax_calculator, :product, :quantity

    def initialize(product, quantity)
      @tax_calculator = TaxCalculator.new
      @product = product
      @quantity = quantity.to_i
    end

    def sale_taxes
      tax_calculator.calculate_tax(product)
    end

    def total_price
      ((product.price + sale_taxes) * quantity).round(2)
    end
  end
end