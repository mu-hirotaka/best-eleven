class ImageController < ApplicationController
require 'redis'
require 'RMagick'
  AWS.config(access_key_id: Settings.s3.access_key_id, secret_access_key: Settings.s3.secret_access_key, region: Settings.s3.region)
  @@random = Random.new(100)

  def create

    formation_id = params[:foId].to_i

    formation_id_to_position = {
      1 => {
        1  => { :x => 270, :y => 100 }, 
        2  => { :x => 540, :y => 100 },
        3  => { :x => 405, :y => 320 },
        4  => { :x => 120, :y => 450 }, 
        5  => { :x => 405, :y => 580 },
        6  => { :x => 670, :y => 450 },
        7  => { :x =>  55, :y => 790 }, 
        8  => { :x => 280, :y => 830 }, 
        9  => { :x => 530, :y => 830 }, 
        10 => { :x => 750, :y => 790 }, 
        11 => { :x => 405, :y => 1100 } 
      },
      2 => {
        1  => { :x => 405, :y => 100 }, 
        2  => { :x => 160, :y => 180 },
        3  => { :x => 650, :y => 180 },

        4  => { :x => 130, :y => 520 }, 
        5  => { :x => 405, :y => 370 },
        6  => { :x => 670, :y => 520 },
        7  => { :x => 405, :y => 630 },

        8  => { :x => 180, :y => 830 }, 
        9  => { :x => 405, :y => 870 }, 
        10 => { :x => 630, :y => 830 }, 
        11 => { :x => 405, :y => 1100 } 
      },
    }
    image_positions = formation_id_to_position[formation_id].nil? ? formation_id_to_position[1] : formation_id_to_position[formation_id]

    logger.debug params.inspect
    ground = Magick::Image.read("public/images/ground.jpg").first

    # conposite image
    player_ids = params[:players]
    image_positions.each_with_index {|(key, value),i|
      if player_ids[i].nil?
        player = Magick::Image.read('public/images/no_image.png').first
      else
        player = Magick::Image.read('public/images/players/' + player_ids[i] + '.jpg').first
      end
      player.resize!(2.0)
      ground = ground.composite(player, value[:x], value[:y], Magick::OverCompositeOp)
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
