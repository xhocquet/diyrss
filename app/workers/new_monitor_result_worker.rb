class NewMonitorResultWorker
  include Sidekiq::Worker

  attr_reader :app_monitor,
              :latest_result,
              :user_monitor

  MAX_MONITOR_COUNT = 500

  def perform(app_monitor_id)
    @app_monitor = AppMonitor.find(app_monitor_id)
    @latest_result = app_monitor.latest_result

    delete_old_results

    app_monitor.user_monitors.find_each do |user_monitor|
      @user_monitor = user_monitor

      # Do not notify if already notified
      next if notification_already_exists?

      # Do not notify if contents are the same
      next if contents_the_same?

      # Do not notify if setting says so
      next unless user_monitor.user.user_profile.notify_site

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
      raise e
    end
  end

  def notification_already_exists?
    user_monitor.user.notifications.unread.where(relevant_thing: user_monitor).present?
  end

  def delete_old_results
    result_count = app_monitor.monitor_results.where(new_content: false).count
    to_delete = [result_count - MAX_MONITOR_COUNT, 0].max
    app_monitor.monitor_results.where(new_content: false).first(to_delete).map(&:destroy)
  end

  def contents_the_same?
    # New contents if it's the first time
    return false if user_monitor.last_viewed_result.nil?

    # First site scrape, new contents!
    return false if latest_result.nil?

    user_monitor.last_viewed_result.payload == latest_result.payload
  end
end
