class BaseController < ApplicationController
  helper_method :current_user

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
end
