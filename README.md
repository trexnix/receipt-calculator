# ReceiptCalculator

## Installation

Mark sure you have Ruby and Bundler installed on your system.

```
git clone https://github.com/trexnix/receipt-calculator.git
cd receipt-calculator
bundle install
gem build receipt-calculator.gemspec
gem install ./receipt-calculator-0.1.0.gem
```

## Usage

### CLI

Suppose we have an input file like this:

```
# input1.text
Quantity, Product, Price
1, book, 12.49
1, music cd, 14.99
1, chocolate bar, 0.85
```

#### Read from file
```
receipt-calculator input1.txt
# =>
# 1, book, 12.49
# 1, music cd, 16.49
# 1, chocolate bar, 0.85
```

Many files supported as well:
```
receipt-calculator input1.txt input2.txt input3.txt ... inputn.txt
...
```

#### Read from STDIN
```
receipt-calculator < input1.txt
...
```

or

```
cat input1 | receipt-calculator
...
```

### API

In your code:
```
require 'receipt_calculator'

puts ReceiptCalculator.print_recept <<~EOS
  Quantity, Product, Price
  1, imported box of chocolates, 10.00
  1, imported bottle of perfume, 47.50
EOS

# =>
# 1, imported box of chocolates, 10.50
# 1, imported bottle of perfume, 54.65
#
# Sales Taxes: 7.65
# Total: 65.15
```

## Testing

To run all the tests, execute:

```
bundle exec rake
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/trexnix/receipt-calculator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ReceiptCalculator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/receipt_calculator/blob/master/CODE_OF_CONDUCT.md).
