class SelectionController < BaseController
require 'redis'
#    Redis.current.set('hoge', 'fuga')
#    @keys = Redis.current.keys
require 'RMagick'
  def index
  end
  def show
  end
  def select
    @bid = params[:bid].to_i
    @fid = params[:fid]
    question_id = params[:qid].to_i

    players = Player.all.map{|player| [player.id, player.attributes]}
    players = Hash[players]
    @all_players = players
    @before_player = players[@bid].nil? ? nil : players[@bid]

    type_to_name = PlayerType.all.map{|record| [record.id, record.title]}
    @type_to_name = Hash[type_to_name]

    question = Question.find_by(id: question_id)
    available_player_type_ids = JSON.parse(question.valid_player_type_ids)

    type_to_players = Player.all.group_by(&:type_id)
    @type_to_players = {}
    if available_player_type_ids.length > 0
      available_player_type_ids.each {|id|
        @type_to_players[id] = type_to_players[id]
      }
    else
      @type_to_players = type_to_players
    end

    @player_counters = PlayerCounter.where(qid: question_id).map{|player| player}.sort_by{|record| - record.num}

    positions = {
      1  => { :type => 1, },
      2  => { :type => 1, },
      3  => { :type => 2, :fw => { :min => 93, :max => 106 }, :mf => { :min => 73, :max => 92 }, :df => { :min => 53, :max => 72 }, :gk => { :min => 50, :max => 52 } },
      4  => { :type => 2, :fw => { :min => 164, :max => 177 }, :mf => { :min => 138, :max => 163 }, :df => { :min => 120, :max => 137 }, :gk => { :min => 116, :max => 119 } },
      5  => { :type => 1, },
      6  => { :type => 2, :fw => { :min => 292, :max => 310 }, :mf => { :min => 264, :max => 291 }, :df => { :min => 236, :max => 263 }, :gk => { :min => 229, :max => 235 } },
      7  => { :type => 2, :fw => { :min => 311, :max => 342 }, :mf => { :min => 343, :max => 370 }, :df => { :min => 371, :max => 400 }, :gk => { :min => 401, :max => 405 } },
      8  => { :type => 2, :fw => { :min => 406, :max => 444 }, :mf => { :min => 445, :max => 493 }, :df => { :min => 494, :max => 531 }, :gk => { :min => 532, :max => 545 } },
      9  => { :type => 2, :fw => { :min => 546, :max => 567 }, :mf => { :min => 568, :max => 596 }, :df => { :min => 597, :max => 623 }, :gk => { :min => 624, :max => 630 } },
      10 => { :type => 1, },
      11  => { :type => 2, :fw => { :min => 665, :max => 688 }, :mf => { :min => 689, :max => 730 }, :df => { :min => 731, :max => 763 }, :gk => { :min => 764, :max => 770 } },
      12  => { :type => 2, :fw => { :min => 771, :max => 804 }, :mf => { :min => 805, :max => 851 }, :df => { :min => 852, :max => 890 }, :gk => { :min => 891, :max => 897 } },
      13  => { :type => 2, :fw => { :min => 898, :max => 934 }, :mf => { :min => 935, :max => 980 }, :df => { :min => 981, :max => 1029 }, :gk => { :min => 1030, :max => 1034 } },
      14  => { :type => 2, :fw => { :min => 1035, :max => 1062 }, :mf => { :min => 1063, :max => 1089 }, :df => { :min => 1090, :max => 1118 }, :gk => { :min => 1119, :max => 1125 } },
      15  => { :type => 1, },
      16  => { :type => 2, :fw => { :min => 1199, :max => 1231 }, :mf => { :min => 1232, :max => 1274 }, :df => { :min => 1275, :max => 1313 }, :gk => { :min => 1314, :max => 1324 } },
      17  => { :type => 2, :fw => { :min => 1325, :max => 1334 }, :mf => { :min => 1335, :max => 1354 }, :df => { :min => 1355, :max => 1378 }, :gk => { :min => 1379, :max => 1383 } },
      18  => { :type => 1, },
    }
    @position = positions[question_id]
  end
end
