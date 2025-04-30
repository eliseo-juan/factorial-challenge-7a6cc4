# frozen_string_literal: true

describe QuestionsController do
  before do
    @token = '123abc'
    @user = create(:user, token: @token)
  end

  describe '#create' do
    it 'creates a question' do
      post '/questions',
           params: { question: { text: 'Why is the sky blue?', tags: %w[science sky] } },
           headers: { 'Authorization' => authenticate_with_token(@token) }

      expect(Question.last.text).to eq('Why is the sky blue?')
      expect(Question.last.tags).to eq(%w[science sky])
    end
  end

  describe '#update' do
    before do
      @question = create(:question, user: @user)
    end

    it 'creates a question' do
      put "/questions/#{@question.id}",
          params: { question: { tags: %w[science sky] } },
          headers: { 'Authorization' => authenticate_with_token(@token) }

      expect(Question.find(@question.id).tags).to eq(%w[science sky])
    end
  end

  describe '#destroy' do
    before do
      @question = create(:question, user: @user)
    end

    it 'destroys the question' do
      delete "/questions/#{@question.id}",
             headers: { 'Authorization' => authenticate_with_token(@token) }

      expect(Question.find_by(id: @question)).to be_nil
    end
  end

  describe '#respond' do
    before do
      @question = create(:question, user: @user)
    end

    it 'updates creates a response' do
      post "/questions/#{@question.id}/answer",
           params: { text: 'Answer to question' },
           headers: { 'Authorization' => authenticate_with_token(@token) }

      expect(Answer.last.text).to eq('Answer to question')
    end
  end

  describe '#rate' do
    before do
      @question = create(:question, user: @user)
    end

    it 'updates question.ratings' do
      post "/questions/#{@question.id}/rate",
           params: { rating: 3 },
           headers: { 'Authorization' => authenticate_with_token(@token) }

      expect(@question.reload.ratings.last).to eq(3)
    end
  end
end
