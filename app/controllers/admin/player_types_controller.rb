class Admin::PlayerTypesController < Admin::Base
  def index
    @types = PlayerType.all
  end

  def show
    type = PlayerType.find(params[:id])
    redirect_to [ :edit, :admin, type ]
  end

  def edit
    @type = PlayerType.find(params[:id])
  end

  def update
    @type = PlayerType.find(params[:id])
    @type.assign_attributes(player_type_params)
    if @type.save
      redirect_to :admin_player_types
    else
      render action 'edit'
    end
  end

  private
  def player_type_params
    params.require(:player_type).permit(:title)
  end

end
