class SelectionController < ApplicationController
require 'redis'
require 'RMagick'
  def index
#    Redis.current.set('hoge', 'fuga')
#    @keys = Redis.current.keys
    @pid_to_player = {
      1  => { :name => '柿谷', :path => '/images/kakitani.png' }, 
      2  => { :name => '香川', :path => '/images/kagawa.png' },
      3  => { :name => '清武', :path => '/images/kiyotake.png' },
      4  => { :name => '長友', :path => '/images/nagatomo.png' }, 
      5  => { :name => '内田', :path => '/images/uchida.png' },
      6  => { :name => '長谷部', :path => '/images/hasebe.png' },
      7  => { :name => '遠藤', :path => '/images/endo.png' }, 
      8  => { :name => '今野', :path => '/images/konno.png' }, 
      9  => { :name => '吉田', :path => '/images/yoshida.png' }, 
      10 => { :name => '森重', :path => '/images/morishige.png' }, 
      11 => { :name => '川島', :path => '/images/kawashima.png' },
      12 => { :name => '権田', :path => '/images/gonda.png' },
      13 => { :name => '酒井高', :path => '/images/gsakai.png' },
      14 => { :name => '酒井宏', :path => '/images/hsakai.png' }, 
      15 => { :name => '本田', :path => '/images/honda.png' },
      16 => { :name => '山口', :path => '/images/yamaguchi.png' },
      17 => { :name => '岡崎', :path => '/images/okazaki.png' },
      18 => { :name => '大迫', :path => '/images/osako.png' },
      19 => { :name => 'みのもんた', :path => '/images/minomonta.jpg' },
      20 => { :name => '大鵬', :path => '/images/taiho.jpg' },
      21 => { :name => 'アンドレ', :path => '/images/andre.jpg' },
      22 => { :name => '雷電', :path => '/images/raiden.jpg' },
      23 => { :name => '牧水', :path => '/images/bokusui.jpg' },
      24 => { :name => 'EXILE', :path => '/images/exile.jpg' },
      25 => { :name => '李白', :path => '/images/rihaku.jpg' },
      26 => { :name => '矢口', :path => '/images/yaguchi.jpg' },
      27 => { :name => '天龍', :path => '/images/tenryu.jpg' },
      28 => { :name => '今井', :path => '/images/imai.jpg' },
      29 => { :name => 'ダルビッシュ', :path => '/images/darvish.jpg' },
      30 => { :name => '田中', :path => '/images/makun.jpg' },
      31 => { :name => '阿部', :path => '/images/abe.jpg' }
    }
  end

  def text
  end

  def show
  end

  def show_text

    positions = {
      1  => { :x => 470, :y => 200, :name => 'みのもんた' }, 
      2  => { :x => 430, :y => 100, :name => 'ベッカム' },
      3  => { :x => 430, :y => 300, :name => '竹内結子' },
      4  => { :x => 330, :y =>  70, :name => 'ピカチュウ' }, 
      5  => { :x => 330, :y => 330, :name => '指原' },
      6  => { :x => 270, :y => 150, :name => 'タモリ' },
      7  => { :x => 270, :y => 250, :name => 'さんま' }, 
      8  => { :x => 150, :y => 130, :name => '北野武' }, 
      9  => { :x => 150, :y => 200, :name => '三浦一良' }, 
      10 => { :x => 150, :y => 270, :name => 'ペレ' }, 
      11 => { :x =>  40, :y => 200, :name => 'トッティ' } 
    }

    ground = Magick::Image.read("public/images/ground.jpg").first

    # draw text
    dr = Magick::Draw.new
    dr.font = 'ヒラギノ丸ゴ-Pro-W4'
    dr.stroke('transparent')
    dr.fill('black')
    dr.pointsize = 18
    
    players = params[:players] || []
    (1..11).to_a.each {|num|
      position = positions[num]
      if players[num-1].nil?
        dr.fill('black')
        random_key = positions.keys.sample
        dr.text(position[:x], position[:y], positions[random_key][:name])
      else
        dr.fill('red')
        dr.text(position[:x], position[:y], players[num-1])
      end
    }
    dr.draw(ground)
    send_data(ground.to_blob, :type => 'image/jpeg', :disposition => 'inline')
  end
  def select
    @bid = params[:bid]
    @fid = params[:fid]

    @positions = {
      1  => { :x => 470, :y => 200, :name => 'みのもんた' }, 
      2  => { :x => 430, :y => 100, :name => 'ベッカム' },
      3  => { :x => 430, :y => 300, :name => '竹内結子' },
      4  => { :x => 330, :y =>  70, :name => 'ピカチュウ' }, 
      5  => { :x => 330, :y => 330, :name => '指原' },
      6  => { :x => 270, :y => 150, :name => 'タモリ' },
      7  => { :x => 270, :y => 250, :name => 'さんま' }, 
      8  => { :x => 150, :y => 130, :name => '北野武' }, 
      9  => { :x => 150, :y => 200, :name => '三浦一良' }, 
      10 => { :x => 150, :y => 270, :name => 'ペレ' }, 
      11 => { :x =>  40, :y => 200, :name => 'トッティ' } 
    }

    @pid_to_player = {
      1  => { :name => '柿谷', :path => '/images/kakitani.png' }, 
      2  => { :name => '香川', :path => '/images/kagawa.png' },
      3  => { :name => '清武', :path => '/images/kiyotake.png' },
      4  => { :name => '長友', :path => '/images/nagatomo.png' }, 
      5  => { :name => '内田', :path => '/images/uchida.png' },
      6  => { :name => '長谷部', :path => '/images/hasebe.png' },
      7  => { :name => '遠藤', :path => '/images/endo.png' }, 
      8  => { :name => '今野', :path => '/images/konno.png' }, 
      9  => { :name => '吉田', :path => '/images/yoshida.png' }, 
      10 => { :name => '森重', :path => '/images/morishige.png' }, 
      11 => { :name => '川島', :path => '/images/kawashima.png' },
      12 => { :name => '権田', :path => '/images/gonda.png' },
      13 => { :name => '酒井高', :path => '/images/gsakai.png' },
      14 => { :name => '酒井宏', :path => '/images/hsakai.png' }, 
      15 => { :name => '本田', :path => '/images/honda.png' },
      16 => { :name => '山口', :path => '/images/yamaguchi.png' },
      17 => { :name => '岡崎', :path => '/images/okazaki.png' },
      18 => { :name => '大迫', :path => '/images/osako.png' },
      19 => { :name => 'みのもんた', :path => '/images/minomonta.jpg' },
      20 => { :name => '大鵬', :path => '/images/taiho.jpg' },
      21 => { :name => 'アンドレ', :path => '/images/andre.jpg' },
      22 => { :name => '雷電', :path => '/images/raiden.jpg' },
      23 => { :name => '牧水', :path => '/images/bokusui.jpg' },
      24 => { :name => 'EXILE', :path => '/images/exile.jpg' },
      25 => { :name => '李白', :path => '/images/rihaku.jpg' },
      26 => { :name => '矢口', :path => '/images/yaguchi.jpg' },
      27 => { :name => '天龍', :path => '/images/tenryu.jpg' },
      28 => { :name => '今井', :path => '/images/imai.jpg' },
      29 => { :name => 'ダルビッシュ', :path => '/images/darvish.jpg' },
      30 => { :name => '田中', :path => '/images/makun.jpg' },
      31 => { :name => '阿部', :path => '/images/abe.jpg' }
    }

    logger.debug params.inspect
  end
end
