class AppMonitorWorker
  include Sidekiq::Worker
  attr_reader :response,
              :app_monitor_id

  def perform(app_monitor_id)
    @app_monitor_id = app_monitor_id
    app_monitor = AppMonitor.find(app_monitor_id)

    Wombat.crawl do
      response = Mechanize.new.get(app_monitor.url)
      # TODO: Filter this down more. Content only?
      contents = response.css app_monitor.selector

      new_result = MonitorResult.create!(
        app_monitor: app_monitor,
        payload: contents.to_s,
      )

      # Trigger notifications from result
      NewMonitorResultWorker.perform_async(new_result.id)

      # Schedule an update in one hour
      AppMonitorWorker.perform_in(10.minutes, app_monitor_id) unless existing_scheduled?
    end
  rescue ArgumentError => e
    if e.message =~ /absolute URL needed/
      app_monitor.error!
    else
      raise e
    end
  end

  def existing_scheduled
    ss = Sidekiq::ScheduledSet.new
    jobs = ss.select {|job| job.klass == 'AppMonitorWorker' }.select {|job| jobs.first.args.first == app_monitor_id }
    jobs.size > 0
  end
end
