# frozen_string_literal: true

require 'cli/decorators/money_decorator'
module Cli
  module Decorators
    class ProductDecorator
      attr_reader :product

      def initialize(product:)
        @product = product
      end

      def to_cli
        "| #{product.code}  | #{formated_name} |  #{formated_price}|"
      end

      def formated_name
        product.name.ljust(12, ' ')
      end

      def formated_price
        MoneyDecorator.new(amount: product.price_in_cents).to_s.rjust(7, ' ')
      end
    end
  end
end
