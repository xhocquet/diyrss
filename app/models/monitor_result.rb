class MonitorResult < ApplicationRecord
  belongs_to :app_monitor, inverse_of: :monitor_results

  enum status: [
    :ok,
    :error,
  ]
end
