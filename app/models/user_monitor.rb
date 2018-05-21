class UserMonitor < ApplicationRecord
  after_commit :destroy_app_monitor_if_last, on: :destroy

  belongs_to :app_monitor, inverse_of: :user_monitors
  belongs_to :user, inverse_of: :user_monitors
  belongs_to :user_category, inverse_of: :user_monitors
  belongs_to :last_viewed_result, class_name: :MonitorResult, required: false

  def destroy_app_monitor_if_last
    app_monitor.destroy! if app_monitor.user_monitors.size.zero?
  end
end
