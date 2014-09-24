class SelectionController < ApplicationController
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
  end
end
