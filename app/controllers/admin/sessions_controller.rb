class Admin::SessionsController < Admin::Base
  skip_before_action :authorize
  def new
    if current_admin_member
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Admin::LoginForm.new(params[:admin_login_form])

    if Admin::Authenticator.new(@form).authenticate()
      session[:admin_member] = 1
      redirect_to :admin_root and return
    end
    render action: 'new'
  end

  def destroy
    session.delete(:admin_member)
    redirect_to :admin_root
  end
end
