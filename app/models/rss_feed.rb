class RssFeed < ApplicationRecord
  belongs_to :user, inverse_of: :rss_feeds

  # has_many :notifications, through: :user

  has_and_belongs_to_many :user_monitors, inverse_of: :rss_feeds

  def notifications
    user.notifications.where(relevant_thing_id: user_monitors.ids)
  end

  def url
    Rails.application.routes.url_helpers.current_user_rss_feed_url(self, format: :xml)
  end
end
