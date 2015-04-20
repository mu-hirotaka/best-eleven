class MyPageController < BaseController
  before_action :login_required

  def index
    @images = UserTwitterPostImage.where(uid: current_user.uid).order(created_at: :desc)
    @images = Kaminari.paginate_array(@images).page(params[:page])

    @image_host = Settings.s3.image_url_path
    questions = Question.all.map{|record| [record.id, record.title]}
    @question_to_title = Hash[questions]

    image_ids = []
    @images.each {|record|
      image_ids.push(record.image_id)
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

    user_images = UserPostImage.where(id: image_ids)
    @image_id_to_image_info = {}
    user_images.each{|record|
      if @image_id_to_image_info[record.id]
      else
        @image_id_to_image_info[record.id] = record
      end
    }

  end
end
