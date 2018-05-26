class ApplicationController < BaseController
  def index
    @user_categories = current_user && current_user.user_categories.includes(:user_monitors)
    @notifications = current_user && current_user.notifications.includes(:relevant_thing).unread || []
  end

  # TODO
  def about
  end
end
