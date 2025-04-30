# frozen_string_literal: true

require 'discounts/discount'
module Discounts
  module BuyInBulk
    # This has the base methods for buy in bulk kind of discounts
    module Base
      include Discount
      def apply(items:)
        items_to_discount = items_to_discount(items:)
        return 0 unless should_apply_discount?(items_to_discount:)

        get_discounted_price(items_to_discount:)
      end

      private

      def items_to_discount(items:)
        items.select { |item| item.code == product_code }
      end

      def should_apply_discount?(items_to_discount:)
        valid? and items_to_discount.size >= products_to_buy
      end
    end
  end
end
