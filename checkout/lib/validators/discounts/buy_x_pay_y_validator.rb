# frozen_string_literal: true

module Validators
  module Discounts
    # This class validates the discount BuyXPayY
    class BuyXPayYValidator
      attr_reader :discount

      def initialize(discount:)
        @discount = discount
      end

      def valid?
        products_to_buy_valid? && free_products_valid?
      end

      private

      def products_to_buy_valid?
        discount.products_to_buy.is_a?(Integer) && discount.products_to_buy.positive?
      end

      def free_products_valid?
        discount.free_products.is_a?(Integer) && discount.free_products.positive?
      end
    end
  end
end
