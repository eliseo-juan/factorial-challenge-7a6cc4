# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def question_answer_email(user, answer)
    @user = user
    @answer = answer
    mail(to: @user.email, subject: 'Your Question Has a Answer!')
  end

  def first_question_email(user)
    @user = user
    mail(to: @user.email, subject: 'Congrats on your first question!')
  end
end
