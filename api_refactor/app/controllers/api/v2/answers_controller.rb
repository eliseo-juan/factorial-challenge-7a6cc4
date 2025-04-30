# frozen_string_literal: true
module Api
  module V2
    class AnswersController < ApplicationController
      before_action :set_answer, only: [:update, :destroy]
      before_action :authorize_user, only: [:update, :destroy]

      def update
        command = UpdateAnswerCommand.new(@answer, answer_params)

        if command.execute
          render jsonapi: @answer
        else
          render jsonapi_errors: @answer.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @answer.destroy
          render jsonapi: @answer
        else
          render jsonapi_errors: @answer.errors, status: :unprocessable_entity
        end
      end

      def create
        @answer = build_answer
        if @answer.save
          QuestionAnswerEmailJob.perform_later(@answer.id)
          render jsonapi: @answer, status: :created
        else
          render jsonapi_errors: @answer.errors, status: :unprocessable_entity
        end
      end

      private

      def set_answer
        @answer = Answer.find(params[:id])
      end

      def build_answer
        question = Question.find(params[:id])
        answer = question.answers.new(answer_params)
        answer.user = current_user
        answer
      end

      def authorize_user
        render jsonapi_errors: { detail: 'Access Unauthorized' }, status: :unauthorized unless current_user == @answer.user
      end

      def answer_params
        params.require(:answer).permit(:text, :rating ,ratings: [])
      end
    end
  end
end
