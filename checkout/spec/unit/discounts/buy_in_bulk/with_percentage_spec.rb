# frozen_string_literal: true

require 'discounts/buy_in_bulk/with_percentage'

RSpec.describe(Discounts::BuyInBulk::WithPercentage) do
  let(:sr1) { Product.new(code: 'SR1', name: 'Strawberries', price_in_cents: 500) }
  let(:cf1) { Product.new(code: 'CF1', name: 'Coffee', price_in_cents: 1123) }
  let(:discount) { described_class.new(product_code: 'SR1', products_to_buy: 3, percentage: 50) }

  describe 'Promo attributes' do
    it 'has product_code' do
      expect(discount).to(respond_to(:product_code))
    end

    it 'has products_to_buy' do
      expect(discount).to(respond_to(:products_to_buy))
    end

    it 'has percentage' do
      expect(discount).to(respond_to(:percentage))
    end
  end

  describe 'Valid promo' do
    it 'is valid' do
      expect(discount).to(be_valid)
    end
  end

  describe 'Invalid promo' do
    let(:promo) { described_class.new(product_code: 'GR1', products_to_buy: 3, percentage: 50) }

    it 'is invalid if products to buy is a string' do
      allow(promo).to receive(:products_to_buy).and_return('A')
      expect(promo).not_to(be_valid)
    end

    it 'is invalid if products to buy is not integer' do
      allow(promo).to receive(:products_to_buy).and_return('-1')
      expect(promo).not_to(be_valid)
    end

    it 'is invalid if new price is a string' do
      allow(promo).to receive(:percentage).and_return('A')
      expect(promo).not_to(be_valid)
    end

    it 'is invalid if percentage is not integer' do
      allow(promo).to receive(:percentage).and_return(-1)
      expect(promo).not_to(be_valid)
    end

    it 'is invalid if percentage is higher thah 100' do
      allow(promo).to receive(:percentage).and_return(101)
      expect(promo).not_to(be_valid)
    end
  end

  describe 'Apply discount with a discount' do
    it 'applies discount to a sr1 cart' do
      discounted_price = discount.apply(items: [sr1, sr1, sr1])
      expect(discounted_price).to(eq(750))
    end

    it 'applies discount to a mixed cart' do
      discounted_price = discount.apply(items: [sr1, cf1, sr1, sr1])
      expect(discounted_price).to(eq(750))
    end

    it 'does not apply discount to a cart with no items to discount' do
      discounted_price = discount.apply(items: [cf1])
      expect(discounted_price).to(eq(0))
    end

    it 'does not apply discount to a cart with no items' do
      discounted_price = discount.apply(items: [])
      expect(discounted_price).to(eq(0))
    end

    it 'does not apply discount to a cart with less items than products_to_buy' do
      discounted_price = discount.apply(items: [sr1, sr1])
      expect(discounted_price).to(eq(0))
    end
  end
end
