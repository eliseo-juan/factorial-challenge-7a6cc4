# frozen_string_literal: true

require "nokogiri"

module Services
  class Reader
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def items
      doc.xpath("//item").map { |xml| Models::Item.build(xml) }
    end

    private

    def doc
      File.open(path) { |f| Nokogiri::XML(f) }
    end
  end
end
