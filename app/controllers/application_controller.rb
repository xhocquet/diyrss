class ApplicationController < BaseController
  def index
    @user_categories = current_user && current_user.user_categories.includes(user_monitors: :app_monitor)
    @results = current_user && @user_categories.map(&:user_monitors).flatten.map(&:app_monitor).map(&:latest_report).flatten.compact
    all_routes = Rails.application.routes.routes
    inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
    @routes_string = inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, nil)
    # @notifications = (current_user && Notification.where(recipient: current_user).includes(:relevant_thing).unread) || []
  end

  # TODO
  def about
  end
end
