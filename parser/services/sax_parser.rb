# frozen_string_literal: true

require "ox"
require "saxerator"

module Services
  class SaxParser
    attr_reader :path, :external_service, :limit

    def initialize(path, external_service, limit: 5_242_880.0)
      @path = path
      @external_service = external_service
      @limit = limit
    end

    def execute
      batch = Models::Batch.new
      parser.for_tag(:item).each do |sax_item|
        item = Models::Item.build_from_ox(sax_item)
        new_size = batch.batch_size + item.lenght
        if new_size > limit
          external_service.call(batch.to_json)
          batch = Models::Batch.new([item])
        else
          batch.add_item(item, new_size)
        end
      end
      external_service.call(batch.to_json)
    end

    private

    def parser
      @parser ||= Saxerator.parser(File.new(path)) do |config|
        config.adapter = :ox
        config.symbolize_keys!
      end
    end
  end
end
