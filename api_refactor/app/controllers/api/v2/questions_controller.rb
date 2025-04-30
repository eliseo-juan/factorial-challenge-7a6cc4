module Api
  module V2
    class QuestionsController < ApplicationController
      before_action :set_question, only: [:show, :update, :destroy, :rate]
      before_action :authorize_user, only: [:update, :destroy]

      def index
        scope = Question.includes(:answers)
        questions = params[:tag] ? scope.where("tags ILIKE ?", "%#{params[:tag]}%") : scope.all
        render jsonapi: questions.order(average_rating: :desc)
      end

      def show
        render jsonapi: @question
      end

      def create
        question = create_question

        if question.save
          FirstQuestionEmailJob.perform_later(current_user.id)
          render jsonapi: question, status: :created
        else
          render jsonapi_errors: question.errors, status: :unprocessable_entity
        end
      end

      def update
        command = UpdateQuestionCommand.new(@question, question_params)

        if command.execute
          render jsonapi: @question
        else
          render jsonapi_errors: @question.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @question.destroy
          head :no_content
        else
          render jsonapi_errors: @question.errors, status: :unprocessable_entity
        end
      end

      private

      def set_question
        @question = Question.find(params[:id])
      end

      def authorize_user
        render jsonapi_errors: { detail: 'Access Unauthorized' }, status: :unauthorized unless current_user == @question.user
      end

      def question_params
        params.require(:question).permit(:text, :rating, tags: [], ratings: [])
      end

      def create_question
        question_params[:ratings] = question_params[:ratings].map(&:to_i) if question_params[:ratings]
        Question.new(question_params.merge(user_id: current_user.id))
      end

    end
  end
end
