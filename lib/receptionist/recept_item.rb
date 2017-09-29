module Receptionist
  class ReceptItem
    attr_accessor :tax_calculator, :product, :quantity

    def initialize(tax_calculator, line_item)
      @tax_calculator = tax_calculator
      @product = line_item[:product]
      @quantity = line_item[:quantity]
    end

    def sale_taxes
      tax_calculator.calculate_tax(product)
    end

    def total
      (product.price + sale_taxes) * quantity
    end

    def details
      {
        product: product,
        quantity: quantity,
        sale_taxes: sale_tax,
        total: total
      }
    end
  end
end