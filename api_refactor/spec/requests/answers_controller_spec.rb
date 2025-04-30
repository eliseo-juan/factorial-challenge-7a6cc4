# frozen_string_literal: true

describe AnswersController do
  before do
    @token = '123abc'
    @user = create(:user, token: @token)
    @question = create(:question)
    @answer = create(:answer, question: @question, user: @user)
  end

  describe '#rate' do
    it 'updates answer.ratings' do
      post "/answers/#{@answer.id}/rate",
           params: { rating: 3 },
           headers: { 'Authorization' => authenticate_with_token(@token) }

      expect(@answer.reload.ratings.last).to eq(3)
    end
  end

  describe '#update' do
    it 'updates the response' do
      put "/answers/#{@answer.id}",
          params: { answer: { text: 'New Answer' } },
          headers: { 'Authorization' => authenticate_with_token(@token) }

      expect(@answer.reload.text).to eq('New Answer')
    end
  end

  describe '#destroy' do
    it 'destroys the answer' do
      delete "/answers/#{@answer.id}",
             headers: { 'Authorization' => authenticate_with_token(@token) }

      expect(Answer.find_by(id: @answer.id)).to be_nil
    end
  end
end
