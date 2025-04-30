# frozen_string_literal: true

require 'discounts/buy_in_bulk/base'

require 'validators/discounts/buy_in_bulk/with_fixed_price_validator'

module Discounts
  module BuyInBulk
    #  This class represents a discount that applies a fixed price to the price of a product
    class WithFixedPrice
      include Discounts::BuyInBulk::Base
      attr_reader :product_code, :products_to_buy, :new_price_in_cents

      def initialize(product_code:, products_to_buy:, new_price_in_cents:)
        @product_code = product_code
        @products_to_buy = products_to_buy
        @new_price_in_cents = new_price_in_cents
      end

      def valid?
        Validators::Discounts::BuyInBulk::WithFixedPriceValidator.new(discount: self).valid?
      end

      def get_discounted_price(items_to_discount:)
        original_price = items_to_discount.sum(&:price_in_cents)
        new_price = new_price_in_cents * items_to_discount.size
        original_price - new_price
      end
    end
  end
end
