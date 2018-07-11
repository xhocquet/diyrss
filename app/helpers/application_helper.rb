module ApplicationHelper
  def monitor_status_color_class(result)
    return 'text-success' if result.present?
    'text-secondary'
  end

  def notification_description(thing)
    if thing.is_a? UserMonitor
      "Go to #{thing.name}!"
    end
  end

  def notification_redirect_path(notif)
    if notif.relevant_thing.is_a? UserMonitor
      redirect_path(notif.relevant_thing.id)
    end
  end

  def favicon_url(monitor)
    if monitor.app_monitor.favicon.attached?
      url_for(monitor.app_monitor.favicon)
    else
      image_path("rss.svg")
    end
  end

  def public_dashboard_url(profile)
    "<a href='#{request.host}:#{request.port}/u/#{profile.dashboard_slug}'>#{request.host}:#{request.port}/u/#{profile.dashboard_slug}</a>"
  end

  def configure_app_monitor_class(app_monitor)
    return "text-danger" if app_monitor.suspicious_results?
    "text-secondary"
  end

  def configure_app_monitor_link(app_monitor)
    latest_result = app_monitor.latest_result
    if latest_result.present?
      admin_monitor_result_diff_path(latest_result.id)
    else
      admin_app_monitor_path(app_monitor)
    end
  end
end
