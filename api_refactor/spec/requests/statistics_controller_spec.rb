# frozen_string_literal: true

describe StatisticsController do
  describe 'GET /statistics' do
    let!(:users) { create_list(:user, 6) }
    let!(:questions) { create_list(:question_with_tags_and_ratings, 10, user: users.sample) }
    let!(:answers) { questions.each { |q| create_list(:answer_with_ratings, 5, question: q, user: users.sample) } }

    before do
      @user = users.first
      @token = @user.token

      get '/statistics',
          headers: { 'Authorization' => authenticate_with_token(@token) }
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the correct statistics' do
      json = response.parsed_body
      expect(json['average_tags_per_question']).not_to be_nil
      expect(json['average_answers_per_question']).not_to be_nil
      expect(json['top_users']).not_to be_nil
      expect(json['average_answer_rating_per_question_tag_count']).not_to be_nil
    end
  end
end
