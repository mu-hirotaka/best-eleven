class SelectionController < ApplicationController
  def index
  end
  def update
    redirect_to :selection_show
  end
  def text
  end
  def show
    positions = {
      1  => { :x => 470, :y => 200, :name => '柿谷' }, 
      2  => { :x => 430, :y => 100, :name => '香川' },
      3  => { :x => 430, :y => 300, :name => '清武' },
      4  => { :x => 330, :y =>  70, :name => '長友' }, 
      5  => { :x => 330, :y => 330, :name => '内田' },
      6  => { :x => 270, :y => 150, :name => '長谷部' },
      7  => { :x => 270, :y => 250, :name => '遠藤' }, 
      8  => { :x => 150, :y => 130, :name => '今野' }, 
      9  => { :x => 150, :y => 200, :name => '吉田' }, 
      10 => { :x => 150, :y => 270, :name => '森重' }, 
      11 => { :x =>  40, :y => 200, :name => '川島' } 
    }

    image_positions = {
      1  => { :x => 470, :y => 150, :path => 'public/images/kakitani.png' }, 
      2  => { :x => 430, :y =>  50, :path => 'public/images/kagawa.png' },
      3  => { :x => 430, :y => 250, :path => 'public/images/kiyotake.png' },
      4  => { :x => 330, :y =>  20, :path => 'public/images/nagatomo.png' }, 
      5  => { :x => 330, :y => 280, :path => 'public/images/uchida.png' },
      6  => { :x => 270, :y => 100, :path => 'public/images/hasebe.png' },
      7  => { :x => 270, :y => 200, :path => 'public/images/endo.png' }, 
      8  => { :x => 150, :y =>  80, :path => 'public/images/konno.png' }, 
      9  => { :x => 150, :y => 150, :path => 'public/images/yoshida.png' }, 
      10 => { :x => 150, :y => 220, :path => 'public/images/morishige.png' }, 
      11 => { :x =>  40, :y => 150, :path => 'public/images/kawashima.png' } 
    }

    ground = Magick::Image.read("public/images/ground.jpg").first

    # conposite image
    image_positions.each {|key, value|
      player = Magick::Image.read(value[:path]).first
      player.resize!(0.6)
      ground = ground.composite(player, value[:x], value[:y], Magick::OverCompositeOp)
    }
    
    # draw text
#    dr = Magick::Draw.new
#    dr.font = 'ヒラギノ丸ゴ-Pro-W4'
#    dr.stroke('transparent')
#    dr.fill('black')
#    dr.pointsize = 18
#    positions.each { |key, value|
#      dr.text(value[:x], value[:y], value[:name])
#    }
#    dr.draw(ground)

    send_data(ground.to_blob, :type => 'image/jpeg', :disposition => 'inline')
  end
  def show_text
    logger.debug params.inspect

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
    (1..10).to_a.each {|num|
      position = positions[num]
      if players[num-1].nil?
        dr.text(position[:x], position[:y], position[:name])
      else
        dr.text(position[:x], position[:y], players[num-1])
      end
    }
    dr.draw(ground)
    send_data(ground.to_blob, :type => 'image/jpeg', :disposition => 'inline')
  end
end
