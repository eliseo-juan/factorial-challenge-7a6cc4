class UpdateAnswerCommand
  def initialize(answer, params)
    @answer = answer
    @params = params
  end

  def execute
    if @params[:rating]
      rate_answer
    else
      update_answer
    end
  end

  private

  def rate_answer
    @answer.ratings << @params[:rating].to_i if @params[:rating].to_i.positive? && @params[:rating].to_i <= 5
    @answer.save
  end

  def update_answer
    @answer.update(@params.except(:rating))
  end
end
