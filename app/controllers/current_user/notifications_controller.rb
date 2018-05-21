module CurrentUser
  class NotificationsController < BaseController
    def show
      @notifications = current_user.notifications.limit(50)
    end
  end
end
