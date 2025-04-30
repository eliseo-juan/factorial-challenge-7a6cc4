# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    text { Faker::ChuckNorris.fact }
    user
  end
  factory :question_with_tags_and_ratings, parent: :question do
    before(:create) do |question|
      rand(1..5).times do
        question.tags << Faker::Hipster.word
      end
      rand(1..5).times do
        question.ratings << rand(1..5)
      end
    end
  end
end
