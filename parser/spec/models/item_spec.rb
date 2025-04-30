# frozen_string_literal: true

require "./models/item"
require "nokogiri"

describe Models::Item do
  let(:xml) do
    "<item xmlns:g=\"http://base.google.com/ns/1.0\">\n
    <description>description</description>\n
    <g:id>1</g:id>\n
    <g:image_link>image_link</g:image_link>
     <g:price>100</g:price>\n
     <g:sale_price>1</g:sale_price>\n
     <link>link</link>
     <title>title</title>\n
     </item>"
  end

  let(:item_xml) { Nokogiri::XML(xml).at("./item") }

  let(:item) { described_class.build(item_xml) }

  it "builds an item from xml" do
    expect(item).to(be_a(described_class))
  end

  it "renders json" do
    expected_json = { id: "1",
                      title: "title",
                      description: "description", }
    expect(item.to_json).to(eq(expected_json))
  end
end
