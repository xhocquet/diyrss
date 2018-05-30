module CurrentUser
  class RssFeedsController < BaseController
    def index
      @rss_feeds = current_user.rss_feeds
    end
  end
end
