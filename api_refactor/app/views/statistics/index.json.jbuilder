# frozen_string_literal: true

json.average_tags_per_question @tags_per_question
json.average_answers_per_question @answers_per_question

json.top_users @top_5_users do |user|
  json.id user.id
  json.username user.username
  json.answers user.answers.size
end

json.average_answer_rating_per_question_tag_count @answer_rating_per_tag_count do |count, average_rating|
  json.tag_count count
  json.average_answer_rating average_rating
end
