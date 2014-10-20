class FormationController < BaseController
  def index
    @formations = Formation.all
    @image_host = Settings.s3.image_url_path
    questions = Question.all.map{|record| [record.id, record.title]}
    @question_to_title = Hash[questions]
    @images = UserPostImage.where(question_id: params[:qid]).order('point DESC').limit(3)

    image_ids = []
    @images.each {|record|
      image_ids.push(record.id)
    }
    user_comments = UserComment.where(image_id: image_ids)
    @image_id_to_comments = {}
    user_comments.each{|record|
      if @image_id_to_comments[record.image_id]
        @image_id_to_comments[record.image_id].push(record)
      else
        @image_id_to_comments[record.image_id] = []
        @image_id_to_comments[record.image_id].push(record)
      end
    }
    @image_id_to_comments.each {|key, val|
      @image_id_to_comments[key].sort_by! {|record| - record.id }
    }
  end
end
