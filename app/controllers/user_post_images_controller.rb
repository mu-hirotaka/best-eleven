class UserPostImagesController < BaseController
  def index
    @images = UserPostImage.all.order(created_at: :desc)
    @images = @images.page(params[:page])

    @image_host = Settings.s3.image_url_path
    questions = Question.all.map{|record| [record.id, record.title]}
    @question_to_title = Hash[questions]

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

  def index_order_by_point
    @images = UserPostImage.all.order(point: :desc)
    @images = @images.page(params[:page])
    @image_host = Settings.s3.image_url_path
    questions = Question.all.map{|record| [record.id, record.title]}
    @question_to_title = Hash[questions]

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

  def index_order_by_comment
    @images = UserPostImage.all.order(created_at: :desc)
    @images = @images.select { |image| image.comment && image.comment.length > 0 }
    @images = Kaminari.paginate_array(@images).page(params[:page])

    @image_host = Settings.s3.image_url_path
    questions = Question.all.map{|record| [record.id, record.title]}
    @question_to_title = Hash[questions]

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

  def index_ranking
    @questions = Question.where("valid_st = ?", 1).order('id DESC')
  end

  def show_ranking
    @images = UserPostImage.all.order(point: :desc)
    @images = @images.select { |image| image.question_id == params[:qid].to_i }
    @images = Kaminari.paginate_array(@images).page(params[:page])

    @image_host = Settings.s3.image_url_path
    questions = Question.all.map{|record| [record.id, record.title]}
    @question_to_title = Hash[questions]

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

  def show
    @image = UserPostImage.find(params[:id])
    @image_host = Settings.s3.image_url_path
    questions = Question.all.map{|record| [record.id, record.title]}
    @question_to_title = Hash[questions]

    user_comments = UserComment.where(image_id: [@image.id])
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
  def good
    @image = UserPostImage.find(params[:id])
    @image.point = @image.point + 1;
    @image.save
    render :json => { :status => 'success' }
  end
end
