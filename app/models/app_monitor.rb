class AppMonitor < ApplicationRecord
  after_commit :trigger_initial_job, on: :create

  has_many :monitor_results, inverse_of: :app_monitor, dependent: :destroy
  has_many :user_monitors, inverse_of: :app_monitor, dependent: :destroy
  has_many :users, through: :user_monitors

  belongs_to :latest_result, class_name: "MonitorResult", required: false

  enum status: [
    :ok,
    :error,
  ]

  private
    def trigger_initial_job
      AppMonitorWorker.perform_async(id)
    end
end
