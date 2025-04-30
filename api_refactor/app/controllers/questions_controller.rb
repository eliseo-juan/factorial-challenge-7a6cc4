# frozen_string_literal: true

class QuestionsController < ApplicationController
  def index
    @questions = if params[:tag]
                   Question.where("tag LIKE '%?%'", params[:tag])
                 else
                   Question.all
                 end

    @questions = @questions.sort_by(&:average_rating)
  end

  def show
    @question = Question.where("id = #{params[:id]}").first
  end

  def create
    @question = Question.new(question_params.merge(user_id: current_user.id))

    if @question.valid? && current_user && current_user.questions.empty?
      @question.save
      UserMailer.first_question_email(current_user)
      render :show
    elsif @question.valid?
      @question.save
      render :show
    else
      render json: @question.errors.full_messages, status: nil
    end
  end

  def update
    @question = Question.where("id = #{params[:id]}").first

    if (current_user != @question.user) && params[:tags].nil?
      render json: 'Access Unauthorized', status: :unauthorized
    elsif current_user != @question.user
      return render :show if @question.update(tags: params[:tags])

      render json: @question.errors.full_messages, status: nil

    else
      return render :show if @question.update(question_params)

      render json: @question.errors.full_messages, status: nil

    end
  end

  def destroy
    @question = Question.where("id = #{params[:id]}").first

    return render json: 'Access Unauthorized', status: :unauthorized if current_user != @question.user

    return render :show if @question.destroy

    render json: @question.errors.full_messages, status: nil
  end

  def answer
    @answer = Answer.new(question_id: params[:id], text: params[:text], user: current_user)

    if @answer.save
      UserMailer.question_answer_email(@answer.question.user, @answer).deliver_now
      render 'answers/show'
    else
      render json: @answer.errors.full_messages, status: nil
    end
  end

  def rate
    @question = Question.where("id = #{params[:id]}").first

    @question.ratings << params[:rating].to_i if params[:rating].to_i.positive? && params[:rating].to_i <= 5

    if @question.save
      render :show
    else
      render json: @question.errors.full_messages, status: nil
    end
  end

  def question_params
    params.require(:question).permit(:text, tags: [], ratings: [])
  end
end
