class FirstQuestionEmailJob < ApplicationJob
  queue_as :default
  queue_adapter = :solid_queue

  def perform(user_id)
    user = User.find(user_id)
    UserMailer.first_question_email(user).deliver_now if user.questions.count == 1
  end
end
