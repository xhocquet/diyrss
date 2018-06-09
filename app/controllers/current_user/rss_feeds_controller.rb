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

    def rss_feed_params
      params.require(:rss_feed).permit(:name, :initial_categories)
    end
  end
end
