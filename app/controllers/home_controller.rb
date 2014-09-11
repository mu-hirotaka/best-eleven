class HomeController < BaseController
  before_action :login_required, only: [:tweet]
  def index
  end
  def tweet
    text = sprintf(Settings.tweet_setting.text, Time.now);
    twitter_client.update(text)
#    twitter_client.update_with_media(text, File.open('./public/images/gazzetta1.png'))
    flash[:notice] = "tweet: #{text}"
    redirect_to action: 'index'
  end

  private
  def twitter_client
    Twitter::Client.new(
      :oauth_token => @current_user.token,
      :oauth_token_secret => @current_user.secret
    )
  end
end
