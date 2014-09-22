class Admin::QuestionsController < Admin::Base
  def index
    @questions = Question.all
  end

  def show
    question = Question.find(params[:id])
    redirect_to [ :edit, :admin, question ]
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.assign_attributes(question_params)
    if @question.save
      redirect_to :admin_questions
    else
      render action 'edit'
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :description, :valid_player_type_ids)
  end

end