module ReceiptCalculator
  class TaxCalculator
    attr_accessor :code_to_rate, :nearest_decimal
    
    def initialize
      @code_to_rate = {
        none: 0,
        basic: 0.1,
        imported: 0.05
      }
      @nearest_decimal = 0.05
    end

    def calculate_tax(product)
      tax = product.price * get_tax_rate_by_product(product)
      tax = (tax / nearest_decimal).ceil * nearest_decimal
      tax.round(2)
    end

    def is_basic_tax_exampt?(product)
      list = [
        "book",
        "chocolate bar",
        "imported box of chocolates",
        "packet of headache pills"
      ]
      list.include? product.name
    end

    def is_import_tax_exampt?(product)
      !product.name.include? "imported"
    end

    def get_tax_rate_by_product(product)
      map_product_to_tax_codes(product)
        .map {|tax_code| code_to_rate[tax_code]}
        .inject(:+)
    end

  private

    def map_product_to_tax_codes(product)
      tax_codes = []
      tax_codes << (is_basic_tax_exampt?(product) ? :none : :basic)
      tax_codes << (is_import_tax_exampt?(product) ? :none : :imported)
      tax_codes
    end
  end
end