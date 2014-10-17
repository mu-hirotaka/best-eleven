class BaseController < ApplicationController
  before_action :check_service_status
  helper_method :current_user

  def check_service_status
    if is_maintenance?
      redirect_to :maintenance_root
    end
  end

  def login_required
    @current_user = current_user
    unless @current_user
      redirect_to '/auth/twitter'
    end
  end

  private
  def current_user
    @current_user ||= SessionUser.new(session) if session[:user_id]
  end

  def is_maintenance?
    maintenance = Maintenance.find_by(:id => 1)
    if maintenance && maintenance.valid_st == 1
      return true
    else
      return false
    end
  end
end
