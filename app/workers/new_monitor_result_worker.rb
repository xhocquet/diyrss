class NewMonitorResultWorker
  include Sidekiq::Worker

  attr_reader :app_monitor,
              :latest_result

  def perform(app_monitor_id)
    @app_monitor = AppMonitor.find(app_monitor_id)
    @latest_result = app_monitor.latest_result

    app_monitor.user_monitors.find_each do |user_monitor|
      next if user_monitor.last_viewed_result_id == latest_result.id

      # Do not notify if already notified
      next if user_monitor.user.notifications.unread.where(relevant_thing: user_monitor).present?

      # Do not notify if contents are the same
      next if user_monitor.last_viewed_result.payload == app_monitor.latest_result.payload

      Notification.create!(
        recipient: user_monitor.user,
        action: Notification.actions[:monitor_update],
        relevant_thing: user_monitor,
      )
    end
  end
end
