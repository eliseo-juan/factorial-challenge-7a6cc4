# frozen_string_literal: true

require 'discounts/buy_in_bulk/base'

require 'validators/discounts/buy_in_bulk/with_percentage_validator'

module Discounts
  module BuyInBulk
    #  This class represents a discount that applies a percentage discount to the price of a product
    class WithPercentage
      include Discounts::BuyInBulk::Base
      attr_reader :product_code, :products_to_buy, :percentage

      def initialize(product_code:, products_to_buy:, percentage:)
        @product_code = product_code
        @products_to_buy = products_to_buy
        @percentage = percentage
      end

      def valid?
        Validators::Discounts::BuyInBulk::WithPercentageValidator.new(discount: self).valid?
      end

      def get_discounted_price(items_to_discount:)
        original_price = items_to_discount.sum(&:price_in_cents)
        new_price = new_price_in_cents(items_to_discount:) * items_to_discount.size
        original_price - new_price
      end

      private

      def new_price_in_cents(items_to_discount:)
        original_price = items_to_discount.first.price_in_cents
        original_price * percentage / 100.0
      end
    end
  end
end
