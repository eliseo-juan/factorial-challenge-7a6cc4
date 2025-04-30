# frozen_string_literal: true

module Discount
  def valid?
    false
  end

  def apply(*)
    0
  end
end
