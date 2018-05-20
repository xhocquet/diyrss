class ApplicationController < BaseController
  def index
    @user_categories = current_user && current_user.user_categories.includes(user_monitors: [app_monitor: :latest_result])
    @results = current_user && @user_categories.flat_map(&:user_monitors).map(&:app_monitor).map(&:latest_result).flatten.compact
    @notifications = current_user && current_user.notifications.includes(:relevant_thing).unread || []
  end

  # TODO
  def about
  end
end
