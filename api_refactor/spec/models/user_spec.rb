# frozen_string_literal: true

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:questions) }
    it { is_expected.to have_many(:answers) }
  end

  describe '#has_secure_token' do
    let(:user) { create(:user) }

    it 'generates a token on create' do
      expect(user.token).not_to be_nil
    end
  end
end
