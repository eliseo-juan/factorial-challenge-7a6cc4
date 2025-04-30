# frozen_string_literal: true

json.array! @questions do |question|
  json.call(question, :id, :text, :tags)
  json.average_rating question.average_rating

  json.user do
    json.id question.user&.id
    json.username question.user&.username
    json.title question.user&.username
  end

  json.answers question.answers do |answer|
    json.id answer.id
    json.text answer.text
    json.average_rating answer.average_rating

    json.user do
      json.id answer.user&.id
      json.username answer.user&.username
      json.title answer.user&.username
    end
  end
end
