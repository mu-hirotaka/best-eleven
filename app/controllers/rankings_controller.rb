class RankingsController < ApplicationController
  def index
  end
  def question
    question_id = params[:qid].to_i
    @player_counters = PlayerCounter.where(qid: question_id).map{|player| player}.sort_by{|record| - record.num}
    players = Player.all.map{|player| [player.id, player.attributes]}
    players = Hash[players]
    @all_players = players

    @qid = question_id
    @user_post_image_num = UserPostImage.where(question_id: question_id).count
  end
  def questions
    @questions = Question.where("valid_st = ?", 1).order('id DESC')
  end
end
