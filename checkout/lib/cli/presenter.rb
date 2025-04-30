# frozen_string_literal: true

require 'cli/decorators/product_decorator'
require 'cli/decorators/cart_decorator'
require 'cli/decorators/discounts/discount_decorator'
require 'cli/decorators/checkout_decorator'

module Cli
  class Presenter
    attr_reader :data_reader, :cart, :products, :discounts

    def initialize(data_reader:, cart:)
      @data_reader = data_reader
      @cart = cart
      @products = data_reader.products
      @discounts = data_reader.discounts
    end

    def clear
      puts `clear`
    end

    def head
      puts 'Shopping Cart'
      puts '----------------------'
    end

    def list_products
      print_products_header
      products.each do |product|
        decorated_product = Decorators::ProductDecorator.new(product:)
        puts decorated_product.to_cli
      end
      print_line
    end

    def list_discounts
      puts 'Available discounts:'
      print_line
      discounts.each do |discount|
        decorated_discount = Decorators::Discounts::DiscountDecorator.new(discount:)
        puts decorated_discount.to_cli
      end
    end

    def list_cart
      decorated_cart = Decorators::CartDecorator.new(cart:)
      print_line
      puts "Your cart contains: #{decorated_cart.to_cli}"
    end

    def list_options
      puts 'Select an option'
      puts '1. Add Green Tea (GR1) to cart'
      puts '2. Add Strawberries (SR1) to cart'
      puts '3. Add Coffee (CF1) to cart'
      puts '4. Add Black tea (BT1) to cart'
      puts '5. Checkout'
      puts '6. Exit'
    end

    def perform_action
      print 'Your selection: '
      option = gets.chomp.to_i
      case option
      when 1, 2, 3, 4
        add_to_cart(option:)
      when 5
        calculate_checkout
      when 6
        exit
      end
    end

    def calculate_checkout
      checkout = Checkout.new(cart:, discounts:)
      checkout.apply_discounts
      decorated_checkout = Decorators::CheckoutDecorator.new(checkout:)
      print_line
      print_checkout_result(checkout: decorated_checkout)
      exit
    end

    private

    def print_line
      puts '---------------------------------'
    end

    def print_products_header
      puts 'Products'
      puts '---------------------------------'
      puts '| Code |     Name     |  Price  |'
      puts '|------|--------------|---------|'
    end

    def codes
      @codes ||= { 1 => 'GR1', 2 => 'SR1', 3 => 'CF1', 4 => 'BT1' }
    end

    def add_to_cart(option:)
      cart.add(data_reader.find_product_by_code(code: codes[option]))
    end

    def print_checkout_result(checkout:)
      puts 'Checkout:'
      puts "Total without discounts: #{checkout.original_price}"
      puts "Discounts: #{checkout.discounted_price}"
      puts "Total: #{checkout.total}"
    end
  end
end
