class AppMonitorWorker
  include Sidekiq::Worker
  attr_reader :response

  def perform(app_monitor_id)
    app_monitor = AppMonitor.find(app_monitor_id)

    Wombat.crawl do
      response = Mechanize.new.get(app_monitor.url)

      new_result = MonitorResult.create!(
        app_monitor: app_monitor,
        payload: response.body,
      )

      NewMonitorResultWorker.perform_async(new_result.id)
    end
  rescue ArgumentError => e
    if e.message =~ /absolute URL needed/
      app_monitor.error!
    else
      raise e
    end
  end
end
