# frozen_string_literal: true

module Cli
  module Decorators
    class MoneyDecorator
      attr_reader :amount

      def initialize(amount:)
        @amount = amount
      end

      def to_s
        format('%.2f€', amount / 100.0)
      end
    end
  end
end
