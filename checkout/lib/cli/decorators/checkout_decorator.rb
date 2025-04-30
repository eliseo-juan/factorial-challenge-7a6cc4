# frozen_string_literal: true

require 'cli/decorators/money_decorator'
module Cli
  module Decorators
    class CheckoutDecorator
      attr_reader :checkout

      def initialize(checkout:)
        @checkout = checkout
      end

      def original_price
        MoneyDecorator.new(amount: checkout.original_price)
      end

      def discounted_price
        MoneyDecorator.new(amount: checkout.discounted_price)
      end

      def total
        MoneyDecorator.new(amount: checkout.total_in_cents)
      end
    end
  end
end
