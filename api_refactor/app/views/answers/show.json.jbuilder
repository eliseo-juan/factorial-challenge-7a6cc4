# frozen_string_literal: true

json.id @answer.id
json.text @answer.text
json.average_rating @answer.average_rating

json.user do
  json.id @answer.user.id
  json.username @answer.user.username
  json.title @answer.user.username
end
