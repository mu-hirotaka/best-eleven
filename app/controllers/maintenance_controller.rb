class MaintenanceController < BaseController
  skip_before_action :check_service_status
  def index
  end
end
