# frozen_string_literal: true

# This class represents the cart of a customer
class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add(item)
    @items << item if item.valid?
  end
end
