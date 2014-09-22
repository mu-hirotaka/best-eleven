class Admin::Base < ApplicationController
  private
  def current_admin_member
    if session[:admin_member]
      @current_admin_member = true
    end
  end

  helper_method :current_admin_member
end
