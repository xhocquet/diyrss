class RedirectsController < BaseController
  def redirect
    user_monitor.update!(
      status: UserMonitor.statuses[:stale],
      last_viewed: Time.zone.now,
    )
    redirect_to user_monitor.url and return
  end

  def user_monitor
    @user_monitor = current_user.user_monitors.find(params.require(:monitor_id))
  end
end
