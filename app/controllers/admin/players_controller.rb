class Admin::PlayersController < Admin::Base
  def index
    @players = Player.all
  end

  def show
    player = Player.find(params[:id])
    redirect_to [ :edit, :admin, player ]
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    @player.assign_attributes(player_params)
    if @player.save
      redirect_to :admin_players
    else
      render action 'edit'
    end
  end

  private
  def player_params
    params.require(:player).permit(:type_id, :full_name, :short_name, :valid_st)
  end
end
