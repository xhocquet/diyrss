class AppMonitor < ApplicationRecord
  after_commit :trigger_initial_jobs, on: :create

  has_many :monitor_results, inverse_of: :app_monitor, dependent: :destroy
  has_many :user_monitors, inverse_of: :app_monitor, dependent: :destroy
  has_many :users, through: :user_monitors
  has_many :selector_suggestions, inverse_of: :app_monitor

  belongs_to :latest_result, class_name: "MonitorResult", required: false

  has_one_attached :favicon

  enum status: [
    :ok,
    :error,
  ]

  def last_new_content
    monitor_results.where(new_content: true).last
  end

  def suspicious_results?
    last_results = monitor_results.last(10).map(&:new_content)
    last_results.count(true) > 8
  end

  private
    def trigger_initial_jobs
      FetchFaviconWorker.perform_async(id)
      AppMonitorWorker.perform_async(id)
    end
end
