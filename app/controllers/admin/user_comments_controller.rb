class Admin::UserCommentsController < Admin::Base
  def index
    @comments = UserComment.all.order(created_at: :desc)
  end
  def destroy
    comment = UserComment.find(params[:id])
    comment.destroy!
    redirect_to :action => 'index'
  end
end
