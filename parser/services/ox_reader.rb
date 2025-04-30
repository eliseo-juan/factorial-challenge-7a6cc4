# frozen_string_literal: true

require "ox"

module Services
  class OxReader
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def items
      Ox.load_file(path, mode: :hash_no_attrs)[:rss][:channel][:item].lazy.map do |ox_item|
        Models::Item.build_from_ox(ox_item)
      end
    end
  end
end
