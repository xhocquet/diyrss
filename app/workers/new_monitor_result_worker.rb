class NewMonitorResultWorker
  include Sidekiq::Worker

  attr_reader :new_result,
              :prev_result

  def perform(new_result_id)
    @new_result = MonitorResult.find(new_result_id)
    @prev_result = MonitorResult.where(app_monitor: current_app_monitor).order(:created_at).last(2).first

    # Different if first
    return new_result.different! if first_result?

    return if new_result.payload == prev_result.payload

    UserMonitor.where(app_monitor: current_app_monitor).includes(:user).find_each do |user_monitor|
      user_monitor.fresh!
      # Notification.create!(
      #   recipient: user_monitor.user,
      #   action: 0,
      #   relevant_thing: @new_result,
      # )
    end
  end

  def current_app_monitor
    @current_app_monitor ||= new_result.app_monitor
  end

  def first_result?
    prev_result.id == new_result.id
  end
end
