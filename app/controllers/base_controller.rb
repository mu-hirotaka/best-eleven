class BaseController < ApplicationController
  protect_from_forgery
  helper_method :current_user

  def login_required
    @current_user = current_user
    unless @current_user
      redirect_to controller: 'home', action: 'index'
    end
  end

  private
  def current_user
    @current_user ||= SessionUser.new(session) if session[:user_id]
  end
end
