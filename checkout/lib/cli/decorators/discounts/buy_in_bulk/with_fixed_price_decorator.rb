# frozen_string_literal: true

require 'cli/decorators/money_decorator'
module Cli
  module Decorators
    module Discounts
      module BuyInBulk
        class WithFixedPriceDecorator
          attr_reader :discount

          def initialize(discount:)
            @discount = discount
          end

          def to_cli
            "Buy #{discount.products_to_buy} or more #{discount.product_code} and pay #{formated_price} for each"
          end

          def formated_price
            MoneyDecorator.new(amount: discount.new_price_in_cents).to_s
          end
        end
      end
    end
  end
end
