# frozen_string_literal: true

require 'discounts/buy_x_pay_y'
require 'cart'

RSpec.describe(Discounts::BuyXPayY) do
  let(:gr1) { Product.new(code: 'GR1', name: 'Green Tea', price_in_cents: 311) }
  let(:cf1) { Product.new(code: 'CF1', name: 'Coffee', price_in_cents: 1123) }
  let(:bt1) { Product.new(code: 'BT1', name: 'Black Tea', price_in_cents: 311) }
  let(:discount) { described_class.new(product_code: 'GR1', products_to_buy: 2, free_products: 1) }

  describe 'Promo attributes' do
    it 'has product_code' do
      expect(discount).to(respond_to(:product_code))
    end

    it 'has products_to_buy' do
      expect(discount).to(respond_to(:products_to_buy))
    end

    it 'has free_products' do
      expect(discount).to(respond_to(:free_products))
    end
  end

  describe 'Valid promo' do
    it 'is valid' do
      expect(discount).to(be_valid)
    end
  end

  describe 'Invalid promo' do
    let(:promo) { described_class.new(product_code: 'GR1', products_to_buy: 1, free_products: 1) }

    it 'is invalid if products to buy is a string' do
      allow(promo).to receive(:products_to_buy).and_return('A')
      expect(promo).not_to(be_valid)
    end

    it 'is invalid if products to buy is not integer' do
      allow(promo).to receive(:products_to_buy).and_return('-1')
      expect(promo).not_to(be_valid)
    end

    it 'is invalid if free products is a string' do
      allow(promo).to receive(:free_products).and_return('A')
      expect(promo).not_to(be_valid)
    end

    it 'is invalid if free products is not integer' do
      allow(promo).to receive(:free_products).and_return(-1)
      expect(promo).not_to(be_valid)
    end
  end

  describe 'Apply discount' do
    it 'applies discount to a cart' do
      discounted_price = discount.apply(items: [gr1, gr1])
      expect(discounted_price).to(eq(311))
    end

    it 'applies discount to a mixed cart' do
      discounted_price = discount.apply(items: [gr1, cf1, gr1])
      expect(discounted_price).to(eq(311))
    end

    it 'applies discount with a different but higher number of items' do
      discounted_price = discount.apply(items: [gr1, gr1, gr1])
      expect(discounted_price).to(eq(311))
    end

    it 'applies discount multiple times' do
      discounted_price = discount.apply(items: [gr1, gr1, gr1, gr1])
      expect(discounted_price).to(eq(622))
    end

    it 'does not apply discount to a cart with no items to discount' do
      discounted_price = discount.apply(items: [cf1, cf1])
      expect(discounted_price).to(eq(0))
    end

    it 'does not apply discount to a cart with no items' do
      discounted_price = discount.apply(items: [])
      expect(discounted_price).to(eq(0))
    end

    it 'does not apply discount to a cart with less items than products_to_buy' do
      discounted_price = discount.apply(items: [gr1])
      expect(discounted_price).to(eq(0))
    end
  end

  describe 'With multiple products' do
    it 'applies discount to a cart with multiple products' do
      discount = described_class.new(product_code: %w[GR1 BT1], products_to_buy: 2, free_products: 1)
      discounted_price = discount.apply(items: [gr1, bt1])
      expect(discounted_price).to(eq(311))
    end
  end
end
