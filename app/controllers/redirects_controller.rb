class RedirectsController < ActionController::Base
  protect_from_forgery with: :exception

  def redirect
    user_monitor.stale!
    redirect_to user_monitor.url and return
  end

  def user_monitor
    @user_monitor = current_user.user_monitors.find(params.require(:monitor_id))
  end
end
