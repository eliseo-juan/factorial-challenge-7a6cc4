# frozen_string_literal: true

require 'validators/product_validator'

# This class represents a product
Product = Struct.new(:code, :name, :price_in_cents) do
  def valid?
    Validators::ProductValidator.new(self).valid?
  end

  def price
    format('%.2f€', price_in_cents / 100.0)
  end
end
