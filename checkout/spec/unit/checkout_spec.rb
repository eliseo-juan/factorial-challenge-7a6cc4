# frozen_string_literal: true

require 'product'
require 'cart'
require 'checkout'

RSpec.describe(Checkout) do
  let(:cart) { instance_double(Cart) }
  let(:items) do
    [
      Product.new(code: 'GR1', name: 'Green Tea', price_in_cents: 311)
    ] * 2
  end

  let(:discounts) { [] }

  describe 'Checkout attributes' do
    it 'calculates orignal price' do
      allow(cart).to(receive(:items).and_return(items))
      checkout = described_class.new(cart:, discounts:)
      expect(checkout.original_price).to(eq(622))
    end
  end
end
