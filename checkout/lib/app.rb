# frozen_string_literal: true

require 'cli/presenter'
class App
  attr_reader :data_reader, :products, :discounts, :cart, :presenter

  def initialize(data_reader:)
    @data_reader = data_reader
    @products = data_reader.products
    @discounts = data_reader.discounts
    @cart = Cart.new
    @presenter = Cli::Presenter.new(data_reader:, cart:)
  end

  def run
    loop do
      display_menu
      perform_action
    end
  end

  private

  def display_menu
    presenter.clear
    presenter.head
    presenter.list_products
    presenter.list_discounts
    presenter.list_cart if cart.items.any?
    presenter.list_options
  end

  def perform_action
    presenter.perform_action
  end
end
