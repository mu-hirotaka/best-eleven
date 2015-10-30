class UserCommentsController < BaseController
  def create
    image_id = params[:image_id].to_i
    comment = params[:comment]
    if valid_comment?(comment)
      user_comment = UserComment.new(image_id: image_id, comment: comment)
      user_comment.save
    end
    redirect_to controller: 'user_post_images', action: 'show', id: image_id
  end

  def index
    @comments = UserComment.all.order(created_at: :desc)
    @comments = @comments.page(params[:page])
  end
  private
  def valid_comment?(comment)
    if comment && comment.length > 0 && comment !~ /href/
      true
    else
      false
    end
  end
end
