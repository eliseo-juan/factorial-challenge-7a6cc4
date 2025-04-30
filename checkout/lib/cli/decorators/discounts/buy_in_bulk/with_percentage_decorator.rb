# frozen_string_literal: true

module Cli
  module Decorators
    module Discounts
      module BuyInBulk
        class WithPercentageDecorator
          attr_reader :discount

          def initialize(discount:)
            @discount = discount
          end

          def to_cli
            "Buy #{discount.products_to_buy} or more #{discount.product_code} and get a #{discount.percentage}% discount in each"
          end
        end
      end
    end
  end
end
