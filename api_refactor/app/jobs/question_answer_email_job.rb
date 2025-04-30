class QuestionAnswerEmailJob < ApplicationJob
  queue_as :default
  queue_adapter = :solid_queue

  def perform(answer_id)
    answer = Answer.find(answer_id)
    UserMailer.question_answer_email(answer.question.user, answer).deliver_now
  end
end
