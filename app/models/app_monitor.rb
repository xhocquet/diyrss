class AppMonitor < ApplicationRecord
  has_many :monitor_results, inverse_of: :app_monitor
  has_many :user_monitors, inverse_of: :app_monitor
  has_many :users, through: :user_monitors

  enum status: [
    :fresh,
    :error,
    :running,
  ]

  def latest_report
    monitor_results.order(:created_at).last
  end
end
