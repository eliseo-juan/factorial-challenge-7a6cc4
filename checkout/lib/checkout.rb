# frozen_string_literal: true

# This class represents the checkout process
class Checkout
  attr_reader :cart, :discounts, :original_price, :discounted_price

  def initialize(cart:, discounts:)
    @cart = cart
    @discounts = discounts
    @original_price = cart.items.sum(&:price_in_cents)
    @discounted_price = 0
  end

  def apply_discounts
    discounts.each do |discount|
      @discounted_price += discount.apply(items: cart.items)
    end
  end

  def total_in_cents
    original_price - discounted_price
  end

  def total
    format('%.2f€', total_in_cents / 100.0)
  end
end
