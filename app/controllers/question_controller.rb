class QuestionController < ApplicationController
  def index
    @questions = Question.where("valid_st = ?", 1).order('id DESC')
  end
end
