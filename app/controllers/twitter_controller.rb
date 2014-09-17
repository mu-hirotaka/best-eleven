class TwitterController < BaseController
  before_action :login_required, only: [:index, :tweet]

  def index

  end
  def tweet
    url = params[:url]
    comment = params[:comment]
    open(url) do |tmp|
      twitter_client.update_with_media(comment, tmp)
    end
    render :json => { :status => 'success' }
  end

  private
  def twitter_client
    Twitter::Client.new(
      :oauth_token => @current_user.token,
      :oauth_token_secret => @current_user.secret
    )
  end
end
