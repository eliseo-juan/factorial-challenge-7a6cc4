# frozen_string_literal: true

require 'cli/decorators/discounts/buy_x_pay_y_decorator'
require 'cli/decorators/discounts/buy_in_bulk/with_fixed_price_decorator'
require 'cli/decorators/discounts/buy_in_bulk/with_percentage_decorator'

module Cli
  module Decorators
    module Discounts
      class DiscountDecorator
        attr_reader :discount

        def initialize(discount:)
          @discount = discount
        end

        def to_cli
          decorator_class.new(discount:).to_cli
        end

        private

        def decorator_class
          case discount
          when ::Discounts::BuyXPayY
            BuyXPayYDecorator
          when ::Discounts::BuyInBulk::WithFixedPrice
            BuyInBulk::WithFixedPriceDecorator
          when ::Discounts::BuyInBulk::WithPercentage
            BuyInBulk::WithPercentageDecorator
          end
        end
      end
    end
  end
end
