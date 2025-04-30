# frozen_string_literal: true

module Cli
  module Decorators
    class CartDecorator
      attr_reader :cart

      def initialize(cart:)
        @cart = cart
      end

      def to_cli
        cart.items.map(&:code).join(', ')
      end
    end
  end
end
