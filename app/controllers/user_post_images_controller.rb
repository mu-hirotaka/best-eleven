class UserPostImagesController < ApplicationController
  def index
    @images = UserPostImage.all.order(created_at: :desc)
    @images = @images.page(params[:page])
    @image_host = Settings.s3.image_url_path
    questions = Question.all.map{|record| [record.id, record.title]}
    @question_to_title = Hash[questions]
  end
  def good
    @image = UserPostImage.find(params[:id])
    @image.point = @image.point + 1;
    @image.save
    render :json => { :status => 'success' }
  end
end
