# frozen_string_literal: true

class DataReader
  def products
    [
      Product.new(code: 'GR1', name: 'Green Tea', price_in_cents: 311),
      Product.new(code: 'SR1', name: 'Strawberries', price_in_cents: 500),
      Product.new(code: 'CF1', name: 'Coffee', price_in_cents: 1123),
      Product.new(code: 'BT1', name: 'Black Tea', price_in_cents: 311)
    ]
  end

  def discounts
    [
      Discounts::BuyXPayY.new(product_code: %w[GR1 BT1], products_to_buy: 2, free_products: 1),
      Discounts::BuyInBulk::WithFixedPrice.new(product_code: 'SR1', products_to_buy: 3, new_price_in_cents: 450),
      Discounts::BuyInBulk::WithPercentage.new(product_code: 'CF1', products_to_buy: 3, percentage: 66.66)
    ]
  end

  def find_product_by_code(code:)
    products.find { |product| product.code == code }
  end
end
