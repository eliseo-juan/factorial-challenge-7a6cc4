# frozen_string_literal: true

module Cli
  module Decorators
    module Discounts
      class BuyXPayYDecorator
        attr_reader :discount

        def initialize(discount:)
          @discount = discount
        end

        def to_cli
          "Buy #{discount.products_to_buy} #{discount.product_code} and pay #{discount.free_products}"
        end
      end
    end
  end
end
