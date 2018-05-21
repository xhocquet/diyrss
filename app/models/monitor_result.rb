class MonitorResult < ApplicationRecord
  belongs_to :app_monitor, inverse_of: :monitor_results

  enum status: [
    :ok,
    :error,
  ]

  def difference_from_last_in_html
    currentIndex = app_monitor.monitor_results.order(:created_at).index(self)
    previousResult = app_monitor.monitor_results.order(:created_at)[currentIndex - 1]

    Diffy::Diff.new(previousResult.payload, payload).to_s(:html)
  end
end
