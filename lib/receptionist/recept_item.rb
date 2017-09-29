require 'receptionist/tax_calculator'

module Receptionist
  class ReceptItem
    attr_accessor :tax_calculator, :product, :quantity

    def initialize(line_item)
      @tax_calculator = TaxCalculator.new
      @product = line_item[:product]
      @quantity = line_item[:quantity]
    end

    def sale_taxes
      tax_calculator.calculate_tax(product)
    end

    def total
      ((product.price + sale_taxes) * quantity).round(2)
    end

    def details
      {
        product: product,
        quantity: quantity,
        sale_taxes: sale_taxes,
        total: total
      }
    end
  end
end