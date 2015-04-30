class Admin::PlayerCounterController < Admin::Base
  def index
    question_id = params[:qid].to_i
    @player_counters = PlayerCounter.where(qid: question_id).order(num: :desc)
  end
  def destroy
    player_counter = PlayerCounter.find(params[:id])
    player_counter.destroy!
    redirect_to :action => 'index'
  end
end
