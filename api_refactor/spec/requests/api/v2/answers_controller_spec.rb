require 'rails_helper'

RSpec.describe 'Api::V2::Answers', type: :request do
  let(:user) { create(:user) }
  let(:answer) { create(:answer, user: user) }
  let(:question) { create(:question, user: user) }
  let(:token) { user.token }

  describe 'POST /create' do
    context 'when the user is authorized' do
      it 'creates an answer' do
        post api_v2_answers_path(question), params: { answer: { text: 'Answer text'} }, headers: { 'Authorization' => authenticate_with_token(token) }
        expect(Answer.last.text).to eq('Answer text')
      end
      it "creates a new Answer for the question" do
        expect{
          post api_v2_answers_path(question), params: { answer: { text: 'Answer text'} }, headers: { 'Authorization' => authenticate_with_token(token) }
        }.to have_enqueued_job(QuestionAnswerEmailJob)
  end
    end
  end
  describe 'PATCH /update' do
    context 'when the user is authorized' do
      it 'updates the answer' do
        patch api_v2_answer_path(answer), params: { answer: { text: 'Updated text' } }, headers: { 'Authorization' => authenticate_with_token(token) }
        expect(answer.reload.text).to eq('Updated text')
      end
    end

    context 'when the user is not authorized' do
      let(:other_user) { create(:user) }
      let(:other_answer) { create(:answer, user: other_user) }

      it 'does not update the answer' do
        patch api_v2_answer_path(other_answer), params: { answer: { text: 'Updated text' } }, headers: { 'Authorization' => authenticate_with_token(token) }
        expect(other_answer.reload.text).not_to eq('Updated text')
      end
    end

    context 'rates' do
      context 'with valid rating' do
        it 'adds the rating to the answer' do
          patch api_v2_answer_path(answer), params: { answer: {rating: 5 }}, headers: { 'Authorization' => authenticate_with_token(token) }
          expect(answer.reload.ratings.last).to eq(5)
        end
      end

      context 'with invalid rating' do
        it 'does not add the rating to the answer' do
          patch api_v2_answer_path(answer), params: { answer: {rating: 6 }}, headers: { 'Authorization' => authenticate_with_token(token) }
          expect(answer.reload.ratings).to be_empty
        end
      end
    end

  end

  describe 'DELETE /destroy' do
    context 'when the user is authorized' do
      it 'deletes the answer' do
        delete api_v2_answer_path(answer), headers: { 'Authorization' => authenticate_with_token(token) }
        expect(Answer.find_by(id: answer.id)).to be_nil
      end
    end

    context 'when the user is not authorized' do
      let(:other_user) { create(:user) }
      let(:other_answer) { create(:answer, user: other_user) }

      it 'does not delete the answer' do
        delete api_v2_answer_path(other_answer), headers: { 'Authorization' => authenticate_with_token(token) }
        expect(Answer.find_by(id: other_answer.id)).not_to be_nil
      end
    end
  end
end
