class ImageController < ApplicationController
require 'redis'
require 'RMagick'
  AWS.config(access_key_id: Settings.s3.access_key_id, secret_access_key: Settings.s3.secret_access_key, region: Settings.s3.region)
  @@random = Random.new(100)

  def create
    formation_id = params[:foId].to_i
    formation = Formation.find_by(id: formation_id)
    positions = JSON.parse(formation.image_position)

    ground = Magick::Image.read("public/images/ground.jpg").first

    # conposite image
    player_ids = params[:players]
    positions.each_with_index {|(key, value),i|
      if player_ids[i].nil?
        player = Magick::Image.read('public/images/no_image.png').first
      else
        player = Magick::Image.read('public/images/players/' + player_ids[i] + '.jpg').first
      end
      player.resize!(2.0)
      ground = ground.composite(player, value["x"].to_i, value["y"].to_i, Magick::OverCompositeOp)
    }
    output_filename = Time.now.strftime("%Y%m%d-%H%M%S") + '-' + @@random.rand(1000).to_s + '.png'

    # S3へ保存
    s3 = AWS::S3.new
    bucket = s3.buckets[Settings.s3.buckets_name]
    object = bucket.objects['images/' + output_filename]
    object.write(ground.to_blob, :acl => :public_read)

    render :json => { :status => 'success', :path => Settings.s3.image_url_path + output_filename }
  end
end
