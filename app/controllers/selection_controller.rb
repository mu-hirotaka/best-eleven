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

    pid_to_player = {
      1  => { :fullName => '武藤嘉紀' }, 
      2  => { :fullName => '皆川佑介' },
      3  => { :fullName => '大迫勇也' },
      4  => { :fullName => '柿谷曜一朗' }, 
      5  => { :fullName => '本田圭佑' },
      6  => { :fullName => '岡崎慎司' },
      7  => { :fullName => '柴崎岳' }, 
      8  => { :fullName => '扇原貴宏' }, 
      9  => { :fullName => '森岡亮太' }, 
      10 => { :fullName => '田中順也' }, 
      11 => { :fullName => '細貝萌' },
      12 => { :fullName => '長谷部誠' },
      13 => { :fullName => '松原健' },
      14 => { :fullName => '酒井高徳' }, 
      15 => { :fullName => '坂井達弥' },
      16 => { :fullName => '酒井宏樹' },
      17 => { :fullName => '吉田麻也' },
      18 => { :fullName => '森重真人' },
      19 => { :fullName => '長友佑都' },
      20 => { :fullName => '水本裕貴' },
      21 => { :fullName => '林彰洋' },
      22 => { :fullName => '西川周作' },
      23 => { :fullName => '川島永嗣' },
      24 => { :fullName => '遠藤保仁' },
      25 => { :fullName => '香川真司' },
      26 => { :fullName => '清武弘嗣' },
      27 => { :fullName => '斎藤学' },
      28 => { :fullName => '内田篤人' },
      29 => { :fullName => '山口蛍' },
      30 => { :fullName => '今野泰幸' },
      31 => { :fullName => '権田修一' },
      32 => { :fullName => '阿部慎之助' },
      33 => { :fullName => 'ダルビッシュ有' },
      34 => { :fullName => '田中将大' },
      35 => { :fullName => 'EXILE' },
      36 => { :fullName => 'みのもんた' },
      37 => { :fullName => '矢口真里' },
    }

    @before_player = pid_to_player[@bid].nil? ? nil : pid_to_player[@bid]

    @type_to_name = {
      1 => 'サッカー日本代表',
      3 => 'プロ野球選手',
      2 => '芸能人',
    }

    @type_to_players = {
      1 => {
        1  => { :fullName => '武藤嘉紀' }, 
        2  => { :fullName => '皆川佑介' },
        3  => { :fullName => '大迫勇也' },
        4  => { :fullName => '柿谷曜一朗' }, 
        5  => { :fullName => '本田圭佑' },
        6  => { :fullName => '岡崎慎司' },
        7  => { :fullName => '柴崎岳' }, 
        8  => { :fullName => '扇原貴宏' }, 
        9  => { :fullName => '森岡亮太' }, 
        10 => { :fullName => '田中順也' }, 
        11 => { :fullName => '細貝萌' },
        12 => { :fullName => '長谷部誠' },
        13 => { :fullName => '松原健' },
        14 => { :fullName => '酒井高徳' }, 
        15 => { :fullName => '坂井達弥' },
        16 => { :fullName => '酒井宏樹' },
        17 => { :fullName => '吉田麻也' },
        18 => { :fullName => '森重真人' },
        19 => { :fullName => '長友佑都' },
        20 => { :fullName => '水本裕貴' },
        21 => { :fullName => '林彰洋' },
        22 => { :fullName => '西川周作' },
        23 => { :fullName => '川島永嗣' },
        24 => { :fullName => '遠藤保仁' },
        25 => { :fullName => '香川真司' },
        26 => { :fullName => '清武弘嗣' },
        27 => { :fullName => '斎藤学' },
        28 => { :fullName => '内田篤人' },
        29 => { :fullName => '山口蛍' },
        30 => { :fullName => '今野泰幸' },
        31 => { :fullName => '権田修一' },
      },
      2 => {
        32 => { :fullName => '阿部慎之助' },
        33 => { :fullName => 'ダルビッシュ有' },
        34 => { :fullName => '田中将大' },
      },
      3 => {
        35 => { :fullName => 'EXILE' },
        36 => { :fullName => 'みのもんた' },
        37 => { :fullName => '矢口真里' },
      },
    }
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
