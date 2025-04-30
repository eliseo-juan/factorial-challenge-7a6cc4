class AnswersController < ApplicationController
  def rate
    @answer = Answer.where("id = #{params[:id]}").first

    @answer.ratings << params[:rating].to_i if (params[:rating].to_i > 0 && params[:rating].to_i <=5)

    if @answer.save
      render :show
    else
      render json: @answer.errors.full_messages, status: '418'
    end
  end

  def update
    @answer = Answer.where("id = #{params[:id]}").first

    if current_user != @answer.user
      return render json: 'Access Unauthorized', status: :unauthorized
    else
      if @answer.update(answer_params)
        return render :show
      else
        return render json: @answer.errors.full_messages, status: '418'
      end
    end
  end

  def destroy
    @answer = Answer.where("id = #{params[:id]}").first

    if current_user != @answer.user
      return render json: 'Access Unauthorized', status: :unauthorized
    end

    if @answer.destroy
      return render :show
    else
      return render json: @answer.errors.full_messages, status: '418'
    end
  end

  def answer_params
    params.require(:answer).permit(:text, :ratings => [])
  end
end
