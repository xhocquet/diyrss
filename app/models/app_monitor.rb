class AppMonitor < ApplicationRecord
  after_create :trigger_initial_job

  has_many :monitor_results, inverse_of: :app_monitor
  has_many :user_monitors, inverse_of: :app_monitor
  has_many :users, through: :user_monitors

  belongs_to :latest_result, class_name: "MonitorResult", required: false

  enum status: [
    :fresh,
    :error,
    :running,
  ]

  private
    def trigger_initial_job
      AppMonitorWorker.perform_async(id)
    end
end
