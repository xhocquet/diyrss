class RssFeedsController < BaseController
  # TODO Toggle auth based on settings
  skip_before_action :authenticate_user!

  def show
    @rss_feed = current_user.rss_feeds.find(params.require(:id))

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def current_user
    User.find(params.require(:user_id))
  end
end
