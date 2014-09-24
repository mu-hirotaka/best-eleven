class Admin::UserPostImagesController < Admin::Base 
  def index
    @images = UserPostImage.all.order(created_at: :desc)
    @image_host = Settings.s3.image_url_path
    questions = Question.all.map{|record| [record.id, record.title]}
    @question_to_title = Hash[questions]
  end
end
