class RssFeed < ApplicationRecord
  belongs_to :user, inverse_of: :rss_feeds

  # has_many :notifications, through: :user

  has_and_belongs_to_many :user_monitors, inverse_of: :rss_feeds

  after_create :set_initial_categories, if: Proc.new { |feed| feed.initial_categories.present? }

  attr_accessor :initial_categories

  def notifications
    user.notifications.where(relevant_thing_id: user_monitors.ids)
  end

  def url
    Rails.application.routes.url_helpers.user_rss_feed_url(user, self, format: :xml)
  end

  private

  def set_initial_categories
    user_monitors << UserCategory.where(id: initial_categories.split(",")).includes(:user_monitors).flat_map(&:user_monitors)
  end
end
