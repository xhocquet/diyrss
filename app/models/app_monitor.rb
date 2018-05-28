class AppMonitor < ApplicationRecord
  after_commit :trigger_initial_job, on: :create

  has_many :monitor_results, inverse_of: :app_monitor, dependent: :destroy
  has_many :user_monitors, inverse_of: :app_monitor, dependent: :destroy
  has_many :users, through: :user_monitors
  has_many :selector_suggestions, inverse_of: :app_monitor

  belongs_to :latest_result, class_name: "MonitorResult", required: false

  enum status: [
    :ok,
    :error,
  ]

  def favicon_url
    "http://#{URI::parse(url).host}/favicon.ico"
  end

  private
    def trigger_initial_job
      AppMonitorWorker.perform_async(id)
    end
end
