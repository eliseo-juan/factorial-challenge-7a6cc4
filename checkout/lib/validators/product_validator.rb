# frozen_string_literal: true

module Validators
  # This class validates the product
  class ProductValidator
    attr_reader :product

    def initialize(product)
      @product = product
    end

    def valid?
      id_valid? && name_valid? && price_valid?
    end

    private

    def id_valid?
      product.code.is_a?(String)
    end

    def name_valid?
      product.name.is_a?(String)
    end

    def price_valid?
      price = product.price_in_cents
      price.is_a?(Integer) && price >= 0
    end
  end
end
