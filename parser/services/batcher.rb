# frozen_string_literal: true

require "./models/batch"
require "./models/item"

module Services
  class Batcher
    attr_reader :items, :limit

    def initialize(items, limit: 5_242_880.0)
      @items = items
      @limit = limit
    end

    def with_service
      batch = Models::Batch.new
      items.each do |item|
        new_size = batch.batch_size + item.lenght
        if new_size > limit
          yield batch
          batch =  Models::Batch.new([item])
        else
         batch.add_item(item, new_size)
        end
      end
      yield batch
    end
  end
end
