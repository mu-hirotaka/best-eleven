class Admin::Base < ApplicationController
  before_action :authorize

  private
  def current_admin_member
    if session[:admin_member]
      @current_admin_member = true
    end
  end

  helper_method :current_admin_member

  def authorize
    unless current_admin_member
      redirect_to :admin_login
    end
  end
end
