module Api
  class RefreshAppMonitorController < ActionController::Base
    def create
      AppMonitorWorker.perform_async(user_monitor.app_monitor.id)

      render json: {}, status: :ok
    end

    def user_monitor
      UserMonitor.find_by(id: params.require(:monitor_id))
    end
  end
end
