# frozen_string_literal: true

require "./services/reader"

describe Services::Reader do
  let(:xml_path) { "./spec/fixtures/feed.xml" }

  it "reads a file and returns an array of items" do
    items = described_class.new("./spec/fixtures/feed.xml").items
    expect(items).to(all(be_a(Models::Item)))
  end
end
