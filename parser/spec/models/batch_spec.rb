# frozen_string_literal: true

require "./models/batch"

describe Models::Batch do
  let(:batch) { described_class.new }
  let(:item) { Models::Item.new }

  it "add items" do
    batch.add_item(item, item.lenght)
    expect(batch.items.size).to(be(1))
    expect(batch.batch_size).to(be(item.lenght))
  end

  it "returns json" do
    expected_json = "[{\"id\":null,\"title\":null,\"description\":null}]"
    batch.add_item(item, item.lenght)
    expect(batch.to_json).to(eq(expected_json))
  end
end
