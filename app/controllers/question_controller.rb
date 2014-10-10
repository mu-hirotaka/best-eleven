class QuestionController < ApplicationController
  def index
    @questions = Question.where("valid_st = ?", 1).order('id DESC')
  end

  def send_request
    comment = params[:comment]

    if comment && comment.length > 0
      user_question_request = UserQuestionRequest.new(comment: comment)
      user_question_request.save
    end
  end
end
