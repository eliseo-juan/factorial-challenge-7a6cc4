# frozen_string_literal: true

RSpec.describe Answer do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:text) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:question) }
  end

  describe '#average_rating' do
    let(:answer) { create(:answer, ratings: [1, 2, 3, 4, 5]) }

    it 'returns the average of the ratings' do
      expect(answer.average_rating).to eq(3)
    end

    context 'when there are no ratings' do
      let(:answer) { create(:answer, ratings: []) }

      it 'returns nil' do
        expect(answer.average_rating).to be_nil
      end
    end
  end
end
