# frozen_string_literal: true

require 'product'

RSpec.describe(Product) do
  describe 'product attributes' do
    let(:product) { described_class.new }

    it 'has a code' do
      expect(product).to(respond_to(:code))
    end

    it 'has a name' do
      expect(product).to(respond_to(:name))
    end

    it 'has a price_in_cents' do
      expect(product).to(respond_to(:price_in_cents))
    end

    it 'has a price' do
      expect(product).to(respond_to(:price))
    end
  end

  describe 'valid item' do
    let(:item) { described_class.new(code: 'GR1', name: 'Green tea', price_in_cents: 311) }

    it 'returns a formated price' do
      expect(item.price).to(eq('3.11€'))
    end
  end

  describe 'invalid item' do
    it 'with invalid item_id' do
      item = described_class.new(code: 1, name: 'NAME', price_in_cents: 311)
      expect(item.valid?).to(be(false))
    end

    it 'with invalid name' do
      item = described_class.new(code: 'GR1', name: 1, price_in_cents: 311)
      expect(item.valid?).to(be(false))
    end

    it 'with invalid price' do
      item = described_class.new(code: 'GR1', name: 'NAME', price_in_cents: '3.11€')
      expect(item.valid?).to(be(false))
    end
  end
end
