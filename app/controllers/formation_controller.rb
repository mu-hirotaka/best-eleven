class FormationController < BaseController
  def index
    @formations = Formation.all
    @image_host = Settings.s3.image_url_path
    questions = Question.all.map{|record| [record.id, record.title]}
    @question_to_title = Hash[questions]
    @images = UserPostImage.where(question_id: params[:qid]).order('point DESC').limit(3)
  end
end
