module ApplicationHelper
  def monitor_status_color_class(result)
    case result && result.status
    when "fresh"
      'text-success'
    else
      'text-secondary'
    end
  end
end
