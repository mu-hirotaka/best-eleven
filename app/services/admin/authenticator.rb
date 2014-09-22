class Admin::Authenticator
  def initialize(admin_form)
    @admin_form = admin_form
  end

  def authenticate()
    if @admin_form && @admin_form.username == 'sk' && @admin_form.password == 'ks'
      return true
    else
      return false
    end
  end
end
