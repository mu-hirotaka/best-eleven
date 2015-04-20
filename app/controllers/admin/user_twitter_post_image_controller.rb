class Admin::UserTwitterPostImageController < Admin::Base
  def index
    @images = UserTwitterPostImage.all.order(created_at: :desc)
    @images = @images.page(params[:page])
  end
  def destroy
    image = UserTwitterPostImage.find(params[:id])
    image.destroy!
    redirect_to :action => 'index'
  end
end
