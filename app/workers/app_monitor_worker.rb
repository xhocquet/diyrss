class AppMonitorWorker
  include Sidekiq::Worker

  MONITOR_INTERVAL = 10.minutes

  attr_reader :app_monitor,
              :app_monitor_id,
              :last_latest_result,
              :payload,
              :response

  def perform(app_monitor_id)
    @app_monitor_id = app_monitor_id

    @app_monitor = AppMonitor.find_by(id: app_monitor_id)
    return if @app_monitor.blank?

    @last_latest_result = app_monitor.latest_result

    # Queue a job for later if we already have an update
    minimum_time_to_update = app_monitor.updated_at + MONITOR_INTERVAL

    if Time.now.utc < minimum_time_to_update
      AppMonitorWorker.perform_in(10.minutes, app_monitor_id)
      return
    end

    @payload = fetch_and_clean_payload
    new_content = check_for_new_content

    new_result = MonitorResult.create!(
      app_monitor: app_monitor,
      new_content: new_content,
      payload: payload,
      status: MonitorResult.statuses[:ok],
    )

    app_monitor.update!(
      latest_result: new_result,
    )

    NewMonitorResultWorker.perform_async(app_monitor.id)

    queue_next_app_monitor_worker

  rescue StandardError => e
    if e.message =~ /absolute URL needed/
      app_monitor.error!
    else
      raise e
    end
  rescue Errno::EMFILE
    queue_next_app_monitor_worker
  rescue OpenSSL::SSL::SSLError
    queue_next_app_monitor_worker
  end

  def fetch_and_clean_payload
    response = Mechanize.new.get(app_monitor.url)

    # Sometimes Mechanize doesn't parse it right away
    response = Nokogiri::HTML(response.body) if response.is_a? Mechanize::File

    if app_monitor.selector.present?
      nodes = response.search(app_monitor.selector)
      body = nodes.map(&:text).sort.join
    else
      body = response.search(:body)
    end

    fragment = Loofah.fragment(body.to_s).scrub!(:whitewash)
    fragment.to_s.gsub(/\s/,"")
  end

  def queue_next_app_monitor_worker
    AppMonitorWorker.perform_in(10.minutes, app_monitor_id)
  end

  def check_for_new_content
    return false if last_latest_result.nil?

    Diffy::Diff.new(last_latest_result.payload, payload).diff.present?
  end
end
