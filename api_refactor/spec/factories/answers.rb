# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    text { Faker::ChuckNorris.fact }
    user
    question
  end

  factory :answer_with_ratings, parent: :answer do
    before(:create) do |answer|
      rand(1..5).times do
        answer.ratings << rand(1..5)
      end
    end
  end
end
