# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email)    { |sequence| "test#{sequence}@example.com" }
    username            { Faker::Internet.username }
    token               { SecureRandom.hex(12) }
  end
end
