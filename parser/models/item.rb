# frozen_string_literal: true

module Models
  class Item < Struct.new(:id, :title, :description)
    def to_json
      {
        id: id,
        title: title,
        description: description,
      }
    end

    def lenght
      to_json.to_s.size
    end

    def self.build(xml_item)
      new(
        xml_item.at("./g:id")&.text,
        xml_item.at("./title")&.text,
        xml_item.at("./description")&.text,
      )
    end

    def self.build_from_ox(ox_item)
      new(
        ox_item.fetch(:"g:id", ""),
        ox_item[:title]&.force_encoding("utf-8"),
        ox_item[:description]&.force_encoding("utf-8"),
      )
    end

    def self.build_from_sax(sax_item)
      {
        id: sax_item.fetch(:"g:id", ""),
        title: sax_item[:title]&.force_encoding("utf-8"),
        description: sax_item[:description]&.force_encoding("utf-8"),
      }
    end
  end
end
