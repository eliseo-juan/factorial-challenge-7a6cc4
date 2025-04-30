# frozen_string_literal: true

require "./services/batcher"

describe Services::Batcher do
  let(:items) { 10.times.map { Models::Item.new } }
  let(:item_size) { Models::Item.new.lenght }

  it "does not split if the limit is not reached" do
    batcher = described_class.new(items)
    batches = batcher.process
    expect(batches.size).to(eq(1))
  end

  it "splits when the limit is reached" do
    limit = item_size * 5 # splits in 2
    batcher = described_class.new(items, limit:)
    batches = batcher.process
    expect(batches.size).to(eq(2))
  end
end
