class UpdateQuestionCommand
  def initialize(question, params)
    @question = question
    @params = params
  end

  def execute
    if @params[:rating]
      rate_question
    else
      update_question
    end
  end

  private

  def rate_question
    if valid_rating?
      @question.ratings << @params[:rating].to_i
      @question.save
    end
  end

  def update_question
    @question.update(@params.except(:rating))
  end

  def valid_rating?
    @params[:rating].to_i.positive? && @params[:rating].to_i <= 5
  end
end
