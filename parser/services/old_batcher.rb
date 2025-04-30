# frozen_string_literal: true

require "./models/batch"
require "./models/item"

module Services
  class OldBatcher
    attr_reader :items, :limit

    def initialize(items, limit: 5_242_880.0)
      @items = items
      @limit = limit
    end

    def process
      batches = [Models::Batch.new]
      items.each do |item|
        add_to_batch(batches, item)
      end
      batches
    end

    private

    def add_to_batch(batches, item)
      last_batch = batches.last
      new_size = last_batch.batch_size + item.lenght
      if new_size > limit
        new_batch = Models::Batch.new([item])
        batches << new_batch
      else
        last_batch.add_item(item, new_size)
      end
    end
  end
end
