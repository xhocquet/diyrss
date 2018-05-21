class RemoveMonitorStatuses < ActiveRecord::Migration[5.2]
  def change
    change_column_default :monitor_results, :status, 0
    change_column_default :app_monitors, :status, 0
    remove_column :user_monitors, :status
  end
end
