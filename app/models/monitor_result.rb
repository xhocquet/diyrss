class MonitorResult < ApplicationRecord
  belongs_to :app_monitor, inverse_of: :monitor_results

  enum status: [
    :ok,
    :error,
  ]

  # def nextResult
  #   app_monitor.monitor_results.where('id > ?', id).first
  # end

  def previous_result
    app_monitor.monitor_results.where('id < ?', id).last
  end

  def difference_from_last_in_html
    return nil if previous_result.nil?
    diffy = Diffy::Diff.new(previous_result.payload, payload)

    return nil if diffy.diff.blank?

    Diffy::Diff.new(previous_result.payload, payload).to_s(:html)
  end
end
