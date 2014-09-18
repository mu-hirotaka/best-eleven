class SelectionController < ApplicationController
require 'redis'
require 'RMagick'
  def index
#    Redis.current.set('hoge', 'fuga')
#    @keys = Redis.current.keys

    @formations = {
      1 => '',
      2 => ''
    }
  end

  def show
  end

  def select
    @bid = params[:bid].to_i
    @fid = params[:fid]

    players = Player.all.map{|player| [player.id, player.attributes]}
    players = Hash[players]

    @before_player = players[@bid].nil? ? nil : players[@bid]

    @type_to_name = {
      1 => 'サッカー日本代表',
      2 => 'プロ野球選手',
      3 => '芸能人',
    }

    @type_to_players = Player.all.group_by(&:type_id)
  end

#  def show_text
#
#    positions = {
#      1  => { :x => 470, :y => 200, :name => 'みのもんた' }, 
#      2  => { :x => 430, :y => 100, :name => 'ベッカム' },
#      3  => { :x => 430, :y => 300, :name => '竹内結子' },
#      4  => { :x => 330, :y =>  70, :name => 'ピカチュウ' }, 
#      5  => { :x => 330, :y => 330, :name => '指原' },
#      6  => { :x => 270, :y => 150, :name => 'タモリ' },
#      7  => { :x => 270, :y => 250, :name => 'さんま' }, 
#      8  => { :x => 150, :y => 130, :name => '北野武' }, 
#      9  => { :x => 150, :y => 200, :name => '三浦一良' }, 
#      10 => { :x => 150, :y => 270, :name => 'ペレ' }, 
#      11 => { :x =>  40, :y => 200, :name => 'トッティ' } 
#    }
#
#    ground = Magick::Image.read("public/images/ground.jpg").first
#
#    # draw text
#    dr = Magick::Draw.new
#    dr.font = 'ヒラギノ丸ゴ-Pro-W4'
#    dr.stroke('transparent')
#    dr.fill('black')
#    dr.pointsize = 18
#    
#    players = params[:players] || []
#    (1..11).to_a.each {|num|
#      position = positions[num]
#      if players[num-1].nil?
#        dr.fill('black')
#        random_key = positions.keys.sample
#        dr.text(position[:x], position[:y], positions[random_key][:name])
#      else
#        dr.fill('red')
#        dr.text(position[:x], position[:y], players[num-1])
#      end
#    }
#    dr.draw(ground)
#    send_data(ground.to_blob, :type => 'image/jpeg', :disposition => 'inline')
#  end

end
