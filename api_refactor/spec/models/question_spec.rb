# frozen_string_literal: true

RSpec.describe Question do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:text) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:answers) }
  end

  describe '#remove_duplicate_tags' do
    let(:question) { create(:question, tags: %w[tag1 tag2 tag1]) }

    it 'removes duplicate tags' do
      question.remove_duplicate_tags
      expect(question.tags).to eq(%w[tag1 tag2])
    end
  end

  describe '#average_rating' do
    let(:question) { create(:question, ratings: [1, 2, 3, 4, 5]) }

    it 'returns the average of the ratings' do
      expect(question.average_rating).to eq(3)
    end

    context 'when there are no ratings' do
      let(:question) { create(:question, ratings: []) }

      it 'returns nil' do
        expect(question.average_rating).to be_nil
      end
    end
  end
end
