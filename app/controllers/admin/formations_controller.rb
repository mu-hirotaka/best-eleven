class Admin::FormationsController < Admin::Base
  def index
    @formations = Formation.all
  end

  def show
    formation = Formation.find(params[:id])
    redirect_to [ :edit, :admin, formation ]
  end

  def edit
    @formation = Formation.find(params[:id])
  end

  def update
    @formation = Formation.find(params[:id])
    @formation.assign_attributes(formation_params)
    if @formation.save
      redirect_to :admin_formations
    else
      render action 'edit'
    end
  end

  private
  def formation_params
    params.require(:formation).permit(:type_name, :title, :css_title, :image_position, :text_position)
  end
end
