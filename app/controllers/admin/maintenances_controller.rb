class Admin::MaintenancesController < Admin::Base
  def show
    @maintenance = Maintenance.find_by(:id => 1)
  end

  def new
    @maintenance = Maintenance.new
  end

  def edit
    @maintenance = Maintenance.find_by(:id => 1)
  end

  def create
    @maintenance = Maintenance.new(maintenance_params)
    if @maintenance.save
      redirect_to :admin_maintenances
    else
      render action: 'new'
    end
  end

  def update
    @maintenance = Maintenance.find_by(:id => params[:maintenance][:id])
    @maintenance.assign_attributes(maintenance_params)
    if @maintenance.save
      redirect_to :admin_maintenances
    else
      render action: 'edit'
    end
  end

  private
  def maintenance_params
    params.require(:maintenance).permit(:id, :valid_st)
  end
end
