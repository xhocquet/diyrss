class AppMonitorWorker
  include Sidekiq::Worker

  attr_reader :response,
              :app_monitor_id

  def perform(app_monitor_id)
    @app_monitor_id = app_monitor_id
    app_monitor = AppMonitor.find(app_monitor_id)

    if app_monitor.updated_at < Time.now.utc - 10.minutes
      AppMonitorWorker.perform_in(10.minutes, app_monitor_id)
      return
    end

    Wombat.crawl do
      response = Mechanize.new.get(app_monitor.url)

      # TODO: Filter this down more. Content only?
      payload = if app_monitor.selector.present?
                  response.css(app_monitor.selector).inspect
                else
                  response.inspect
                end

      new_result = MonitorResult.create!(
        app_monitor: app_monitor,
        payload: payload,
        status: MonitorResult.statuses[:ok],
      )

      app_monitor.update!(
        latest_result: new_result,
      )

      NewMonitorResultWorker.perform_async(app_monitor.id)

      AppMonitorWorker.perform_in(10.minutes, app_monitor_id)
    end
  rescue StandardError => e
    if e.message =~ /absolute URL needed/
      app_monitor.error!
    else
      if Rails.env.development?
        raise e
      else
        Rollbar.error(e)
      end
    end
  end
end
