# frozen_string_literal: true

module Models
  class Batch
    attr_accessor :items, :batch_size

    def initialize(items = [])
      @items = items
      @batch_size = items.sum(&:lenght)
    end

    def to_json
      items.map(&:to_json).to_json
    end

    def add_item(item, new_size)
      @items << item
      @batch_size = new_size
    end
  end
end
