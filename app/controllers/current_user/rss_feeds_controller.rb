module CurrentUser
  class RssFeedsController < BaseController
    def index
      @rss_feeds = current_user.rss_feeds
    end

    def new
      @rss_feed = current_user.rss_feeds.new
    end

    def create
      @rss_feed = current_user.rss_feeds.new rss_feed_params

      if @rss_feed.save
        redirect_to current_user_rss_feed_path(@rss_feed)
      else
      end
    end

    def show
      @rss_feed = current_user.rss_feeds.find(params.require(:id))
    end

    def update
      @rss_feed = current_user.rss_feeds.find(params.require(:id))

      if @rss_feed.update rss_feed_params
        flash[:notice] = "Successfully updated rss feed."
      else
        flash[:alert] = "Could not update rss feed. Try again."
      end

      redirect_to current_user_rss_feed_path(@rss_feed)
    end

    def rss_feed_params
      params.require(:rss_feed).permit(:name, :initial_categories)
    end
  end
end
