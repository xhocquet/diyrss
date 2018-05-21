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

      # Schedule an 10 minutes unless we've already got jobs. No need for duplicates!
      AppMonitorWorker.perform_in(10.minutes, app_monitor_id) unless existing_scheduled?
    end
  rescue StandardError => e
    if e.message =~ /absolute URL needed/
      app_monitor.error!
    else
      Rollbar.error(e)
    end
  end

  def existing_scheduled
    ss = Sidekiq::ScheduledSet.new
    jobs = ss.select {|job| job.klass == 'AppMonitorWorker' }.select {|job| jobs.first.args.first == app_monitor_id }
    jobs.size > 0
  end
end
