class NewMonitorResultWorker
  include Sidekiq::Worker

  attr_reader :app_monitor,
              :latest_result,
              :user_monitor

  def perform(app_monitor_id)
    @app_monitor = AppMonitor.find(app_monitor_id)
    @latest_result = app_monitor.latest_result

    app_monitor.user_monitors.find_each do |user_monitor|
      @user_monitor = user_monitor

      # Do not notify if already notified
      next if notification_already_exists?

      # Do not notify if contents are the same
      next if contents_the_same?

      Notification.create!(
        recipient: user_monitor.user,
        action: Notification.actions[:monitor_update],
        relevant_thing: user_monitor,
      )
    end
  rescue StandardError => e
    if e.message =~ /absolute URL needed/
      app_monitor.error!
    else
      Rollbar.error(e)
    end
  end

  def notification_already_exists?
    user_monitor.user.notifications.unread.where(relevant_thing: user_monitor).present?
  end

  def contents_the_same?
    user_monitor.last_viewed_result.payload == latest_result.payload
  end
end
