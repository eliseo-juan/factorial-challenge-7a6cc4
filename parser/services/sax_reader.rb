# frozen_string_literal: true

require "ox"
require "saxerator"

module Services
  class SaxReader
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def items
      parser = Saxerator.parser(File.new(path)) do |config|
        config.adapter = :ox
        config.symbolize_keys!
      end
      items = []
      parser.for_tag(:item).each do |sax_item|
        items << Models::Item.build_from_ox(sax_item)
      end
      items
    end
  end
end
