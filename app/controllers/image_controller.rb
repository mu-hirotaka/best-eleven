class ImageController < ApplicationController
require 'redis'
require 'RMagick'
  AWS.config(access_key_id: Settings.s3.access_key_id, secret_access_key: Settings.s3.secret_access_key, region: Settings.s3.region)
  @@random = Random.new(100)

  def create
    image_positions = {
      1  => { :x => 150, :y => 60 }, 
      2  => { :x => 340, :y => 60 },
      3  => { :x => 243, :y => 200 },
      4  => { :x =>  80, :y => 270 }, 
      5  => { :x => 243, :y => 350 },
      6  => { :x => 410, :y => 270 },
      7  => { :x =>  35, :y => 490 }, 
      8  => { :x => 170, :y => 520 }, 
      9  => { :x => 315, :y => 520 }, 
      10 => { :x => 450, :y => 490 }, 
      11 => { :x => 243, :y => 670 } 
    }

    pid_to_img = {
      0  => { :path => 'public/images/no_image.png' },
      1  => { :path => 'public/images/kakitani.png' }, 
      2  => { :path => 'public/images/kagawa.png' },
      3  => { :path => 'public/images/kiyotake.png' },
      4  => { :path => 'public/images/nagatomo.png' }, 
      5  => { :path => 'public/images/uchida.png' },
      6  => { :path => 'public/images/hasebe.png' },
      7  => { :path => 'public/images/endo.png' }, 
      8  => { :path => 'public/images/konno.png' }, 
      9  => { :path => 'public/images/yoshida.png' }, 
      10 => { :path => 'public/images/morishige.png' }, 
      11 => { :path => 'public/images/kawashima.png' },
      12 => { :path => 'public/images/gonda.png' },
      13 => { :path => 'public/images/gsakai.png' },
      14 => { :path => 'public/images/hsakai.png' }, 
      15 => { :path => 'public/images/honda.png' },
      16 => { :path => 'public/images/yamaguchi.png' },
      17 => { :path => 'public/images/okazaki.png' },
      18 => { :path => 'public/images/osako.png' },
      19 => { :path => 'public/images/minomonta.jpg' },
      20 => { :path => 'public/images/taiho.jpg' },
      21 => { :path => 'public/images/andre.jpg' },
      22 => { :path => 'public/images/raiden.jpg' },
      23 => { :path => 'public/images/bokusui.jpg' },
      24 => { :path => 'public/images/exile.jpg' },
      25 => { :path => 'public/images/rihaku.jpg' },
      26 => { :path => 'public/images/yaguchi.jpg' },
      27 => { :path => 'public/images/tenryu.jpg' },
      28 => { :path => 'public/images/imai.jpg' },
      29 => { :path => 'public/images/darvish.jpg' },
      30 => { :path => 'public/images/makun.jpg' },
      31 => { :path => 'public/images/abe.jpg' }
    }

    logger.debug params.inspect
    ground = Magick::Image.read("public/images/ground-half.jpg").first

    # conposite image
    player_ids = params[:players]
    image_positions.each_with_index {|(key, value),i|
      if player_ids[i].nil?
        player = Magick::Image.read('public/images/no_image.png').first
      else
        player = Magick::Image.read(pid_to_img[player_ids[i].to_i][:path]).first
      end
      player.resize!(0.8)
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
