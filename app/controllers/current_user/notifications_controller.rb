module CurrentUser
  class NotificationsController < BaseController
    def show
      @notifications = current_user.notifications
    end
  end
end
