module ApplicationHelper
  def monitor_status_color_class(result)
    if result.present?
      'text-success'
    else
      'text-secondary'
    end
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
end
