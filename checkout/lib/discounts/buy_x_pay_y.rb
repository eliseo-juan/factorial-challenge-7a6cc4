# frozen_string_literal: true

require 'validators/discounts/buy_x_pay_y_validator'
require 'discounts/discount'

module Discounts
  # This class represents a discount that applies a fixed price to the price of a product
  class BuyXPayY
    include Discount
    attr_reader :product_code, :products_to_buy, :free_products

    def initialize(product_code:, products_to_buy:, free_products:)
      @product_code = product_code
      @products_to_buy = products_to_buy
      @free_products = free_products
    end

    def valid?
      Validators::Discounts::BuyXPayYValidator.new(discount: self).valid?
    end

    def apply(items:)
      items_to_discount = items_to_discount(items:)
      return 0 unless should_apply_discount?(items_to_discount:)

      get_discounted_price(items_to_discount:)
    end

    private

    def items_to_discount(items:)
      items.select { |item| product_code.include?(item.code) }
    end

    def should_apply_discount?(items_to_discount:)
      valid? and items_to_discount.size >= products_to_buy
    end

    def get_discounted_price(items_to_discount:)
      times_to_apply = items_to_discount.size / products_to_buy
      original_price = items_to_discount.first.price_in_cents
      original_price * times_to_apply
    end
  end
end
