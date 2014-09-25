require 'redis'
require 'RMagick'
class ImageController < ApplicationController
  AWS.config(access_key_id: Settings.s3.access_key_id, secret_access_key: Settings.s3.secret_access_key, region: Settings.s3.region)
  @@random = Random.new(100)

  def create
    question_id = params[:qid].to_i
    formation_id = params[:foId].to_i
    formation = Formation.find_by(id: formation_id)
    positions = JSON.parse(formation.image_position)

    ground = Magick::Image.read("public/images/ground.jpg").first

    # draw text
    dr = Magick::Draw.new
    dr.font = Rails.root.join('app', 'assets', 'fonts', 'ipaexg.ttf').to_s
    dr.stroke('transparent')
    dr.fill('black')
    dr.pointsize = 32
    dr.text_antialias = true

    # conposite image
    player_ids = params[:players]
    players = Player.where(id: player_ids).map{|record| [record.id, record.attributes]}
    players = Hash[players]
    positions.each_with_index {|(key, value),i|
      if player_ids[i].nil?
        player = Magick::Image.read('public/images/no_image.png').first
      else
        player = Magick::Image.read('public/images/players/' + player_ids[i] + '.jpg').first
      end
      tmp_player = players[player_ids[i].to_i]
      metrix = dr.get_type_metrics(tmp_player["short_name"])
      dr.text(value["x"].to_i + 100 - metrix.width / 2, value["y"].to_i + 230, tmp_player["short_name"])
      player.resize!(2.0)
      ground = ground.composite(player, value["x"].to_i, value["y"].to_i, Magick::OverCompositeOp)
    }
    dr.draw(ground)

    output_filename = Time.now.strftime("%Y%m%d-%H%M%S") + '-' + @@random.rand(1000).to_s + '.png'

    # S3へ保存
    s3 = AWS::S3.new
    bucket = s3.buckets[Settings.s3.buckets_name]
    object = bucket.objects[output_filename]
    object.write(ground.to_blob, :acl => :public_read)

    # DB保存
    user_post_image = UserPostImage.new(question_id: question_id, image_name: output_filename)
    user_post_image.save

    render :json => { :status => 'success', :path => Settings.s3.image_url_path + output_filename }
  end
end
module Magick
  class Draw
    # Specify text drawing font
    def font(name)
      primitive "font '#{name}'"
    end
  end
end
