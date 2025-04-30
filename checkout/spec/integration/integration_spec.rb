# frozen_string_literal: true

require 'product'
require 'cart'
require 'checkout'
require 'discounts/buy_x_pay_y'
require 'discounts/buy_in_bulk/with_fixed_price'
require 'discounts/buy_in_bulk/with_percentage'

describe 'Integration' do
  let(:gr1) { Product.new(code: 'GR1', name: 'Green Tea', price_in_cents: 311) }
  let(:sr1) { Product.new(code: 'SR1', name: 'Strawberries', price_in_cents: 500) }
  let(:cf1) { Product.new(code: 'CF1', name: 'Coffee', price_in_cents: 1123) }
  let(:bt1) { Product.new(code: 'BT1', name: 'Black Tea', price_in_cents: 311) }

  let(:cart) { Cart.new }

  let(:discounts) do
    [
      Discounts::BuyXPayY.new(product_code: %w[BT1 GR1], products_to_buy: 2, free_products: 1),
      Discounts::BuyInBulk::WithFixedPrice.new(product_code: 'SR1', products_to_buy: 3, new_price_in_cents: 450),
      Discounts::BuyInBulk::WithPercentage.new(product_code: 'CF1', products_to_buy: 3, percentage: 66.66)
    ]
  end

  it 'returns 3.11€ for the first test case' do
    cart.add(gr1)
    cart.add(gr1)
    checkout = Checkout.new(cart:, discounts:)
    checkout.apply_discounts

    expect(checkout.total).to(eq('3.11€'))
  end

  # rubocop:disable RSpec/ExampleLength
  it 'returns 16.61€ for the second test case' dos
    cart.add(sr1)
    cart.add(sr1)
    cart.add(gr1)
    cart.add(sr1)
    checkout = Checkout.new(cart:, discounts:)
    checkout.apply_discounts

    expect(checkout.total).to(eq('16.61€'))
  end

  it 'returns 30.57€ for the third test case' do
    cart.add(gr1)
    cart.add(cf1)
    cart.add(sr1)
    cart.add(cf1)
    cart.add(cf1)
    checkout = Checkout.new(cart:, discounts:)
    checkout.apply_discounts

    expect(checkout.total).to(eq('30.57€'))
  end
  # rubocop:enable RSpec/ExampleLength

  it 'new example with teas' do
    cart.add(gr1)
    cart.add(bt1)
    checkout = Checkout.new(cart:, discounts:)
    checkout.apply_discounts

    expect(checkout.total).to(eq('3.11€'))
  end

  it 'new example with teas' do
    cart.add(bt1)
    cart.add(bt1)
    checkout = Checkout.new(cart:, discounts:)
    checkout.apply_discounts

    expect(checkout.total).to(eq('3.11€'))
  end
end
