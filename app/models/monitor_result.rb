class MonitorResult < ApplicationRecord
  belongs_to :app_monitor, inverse_of: :monitor_results

  enum status: [
    :not_different,
    :loading,
    :different,
    :error,
  ]
end
