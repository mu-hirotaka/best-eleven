class UserCommentsController < BaseController
  def create
    image_id = params[:image_id].to_i
    comment = params[:comment]
    if comment && comment.length > 0
      user_comment = UserComment.new(image_id: image_id, comment: comment)
      user_comment.save
    end
    redirect_to controller: 'user_post_images', action: 'show', id: image_id
  end
end
