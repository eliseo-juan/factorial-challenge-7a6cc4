# frozen_string_literal: true

module Validators
  module Discounts
    module BuyInBulk
      # This class validates the discount WithPercentage
      class WithPercentageValidator
        attr_reader :discount

        def initialize(discount:)
          @discount = discount
        end

        def valid?
          products_to_buy_valid? && percentage_valid?
        end

        private

        def products_to_buy_valid?
          discount.products_to_buy.is_a?(Integer) && discount.products_to_buy.positive?
        end

        def percentage_valid?
          !discount.percentage.is_a?(String) && discount.percentage.positive? && discount.percentage <= 100
        end
      end
    end
  end
end
