# frozen_string_literal: true

# Create Users
test_user_1 = User.create(email: 'test-1@example.com', username: 'test-user-1')
test_user_2 = User.create(email: 'test-2@example.com', username: 'test-user-2')
test_user_3 = User.create(email: 'test-3@example.com', username: 'test-user-3')

users = [test_user_3, test_user_2, test_user_1, nil, nil]

# Create Questions
10.times do
  q = Question.new(text: Faker::ChuckNorris.fact, user: users.sample)

  rand(1..5).times do
    q.tags << Faker::Hipster.word
  end

  rand(1..5).times do
    q.ratings << rand(1..5)
  end

  q.save
end

# Remove nils from users array
users = users.compact

question_ids = Question.pluck(:id)

# Create Responses
20.times do
  a = Answer.create(text: Faker::Hipster.sentence, user: users.sample, question_id: question_ids.sample)

  rand(1..5).times do
    a.ratings << rand(1..5)
  end

  a.save
end
