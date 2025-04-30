# frozen_string_literal: true

module Validators
  module Discounts
    module BuyInBulk
      # This class validates the discount WithFixedPrice
      class WithFixedPriceValidator
        attr_reader :discount

        def initialize(discount:)
          @discount = discount
        end

        def valid?
          products_to_buy_valid? && new_price_in_cents_valid?
        end

        private

        def products_to_buy_valid?
          discount.products_to_buy.is_a?(Integer) && discount.products_to_buy.positive?
        end

        def new_price_in_cents_valid?
          discount.new_price_in_cents.is_a?(Integer) && discount.new_price_in_cents.positive?
        end
      end
    end
  end
end
