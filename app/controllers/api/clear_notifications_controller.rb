module Api
  class ClearNotificationsController < ::BaseController
    def create
      current_user.notifications.unread.update_all(read_at: Time.zone.now)

      render json: {}, status: :ok
    end
  end
end
