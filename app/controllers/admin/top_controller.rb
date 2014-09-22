class Admin::TopController < Admin::Base
  skip_before_action :authorize
  def index

  end
end
