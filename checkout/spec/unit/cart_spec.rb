# frozen_string_literal: true

require 'cart'
require 'product'

RSpec.describe(Cart) do
  let(:cart) { described_class.new }
  let(:gr1) { Product.new(code: 'GR1', name: 'Green Tea', price_in_cents: 311) }
  let(:sr1) { Product.new(code: 'SR1', name: 'Strawberries', price_in_cents: 500) }
  let(:cf1) { Product.new(code: 'CF1', name: 'Coffee', price_in_cents: 1123) }

  describe 'cart attributes' do
    it 'has items' do
      expect(cart).to(respond_to(:items))
    end
  end

  describe 'Adding 1 item' do
    before do
      cart.add(gr1)
    end

    it 'adds item' do
      expect(cart.items).to(eq([gr1]))
    end
  end

  describe 'Adding multiple items' do
    before do
      cart.add(gr1)
      cart.add(sr1)
      cart.add(cf1)
      cart.add(cf1)
    end

    it 'adds items' do
      expect(cart.items).to(eq([gr1, sr1, cf1, cf1]))
    end
  end
end
