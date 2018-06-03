class ApplicationController < BaseController
  def index
    @user_categories = current_user && current_user.user_categories.includes(user_monitors: :app_monitor) || []
    @notifications = current_user && current_user.notifications.includes(:relevant_thing).unread.to_a || []
    render 'index', layout: 'dashboard'
  end
end
