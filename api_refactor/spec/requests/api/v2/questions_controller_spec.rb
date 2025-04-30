require 'rails_helper'

RSpec.describe "Api::V2::Questions", type: :request do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:token) { user.token }

  describe "GET /index" do
    before do
      get api_v2_questions_path,
      headers: { 'Authorization' => authenticate_with_token(token) }
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    before do
      get api_v2_question_path(question),
      headers: { 'Authorization' => authenticate_with_token(token) }
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context 'with valid parameters' do
      let(:valid_params) do
        { question: { text: 'Some question', tags: ['tag1', 'tag2'], ratings: [1, 2, 3], user_id: user.id } }
      end

      it 'creates a new question' do
        expect {
          post api_v2_questions_path, params: valid_params, headers: { 'Authorization' => authenticate_with_token(token) }
        }.to change(Question, :count).by(1)
      end

      it 'returns a successful response' do
        post api_v2_questions_path, params: valid_params, headers: { 'Authorization' => authenticate_with_token(token) }
        expect(response).to have_http_status(:created)
      end

      it "creates a new Question and enqueues a job" do
        expect {
          post api_v2_questions_path, params: valid_params, headers: { 'Authorization' => authenticate_with_token(token) }
        }.to have_enqueued_job(FirstQuestionEmailJob)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { question: { text: '', tags: ['tag1', 'tag2'], ratings: [1, 2, 3], user_id: user.id } }
      end

      it 'does not create a new question' do
        expect {
          post api_v2_questions_path, params: invalid_params, headers: { 'Authorization' => authenticate_with_token(token) }
        }.not_to change(Question, :count)
      end

      it 'returns an unprocessable entity response' do
        post api_v2_questions_path, params: invalid_params, headers: { 'Authorization' => authenticate_with_token(token) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "POST /update" do
    context 'with valid parameters' do
      let(:valid_params) do
        { question: { text: 'Updated question', tags: ['tag1', 'tag2'], ratings: [1, 2, 3] } }
      end

      it 'updates the question' do
        patch api_v2_question_path(question), params: valid_params, headers: { 'Authorization' => authenticate_with_token(token) }
        question.reload
        expect(question.text).to eq('Updated question')
      end

      it 'returns a successful response' do
        patch api_v2_question_path(question), params: valid_params, headers: { 'Authorization' => authenticate_with_token(token) }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { question: { text: '', tags: ['tag1', 'tag2'], ratings: [1, 2, 3] } }
      end

      it 'does not update the question' do
        patch api_v2_question_path(question), params: invalid_params, headers: { 'Authorization' => authenticate_with_token(token) }
        question.reload
        expect(question.text).not_to eq('')
      end

      it 'returns an unprocessable entity response' do
        patch api_v2_question_path(question), params: invalid_params, headers: { 'Authorization' => authenticate_with_token(token) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end



    context 'rates a question' do
      let(:question_params) do
        { question: { rating: 5 } }
      end
      it "adds a rating to the question" do
        patch api_v2_question_path(question), params: question_params, headers: { 'Authorization' => authenticate_with_token(token) }
        question.reload
        expect(question.ratings.last).to eq(5)
      end
    end

   end
   describe "DELETE /destroy" do
    it "destroys the requested question" do
        delete api_v2_question_path(question), headers: { 'Authorization' => authenticate_with_token(token) }
        expect(Question.find_by(id: question.id)).to be_nil
    end
  end


end
