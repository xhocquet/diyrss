class AddLastestResultToAppMonitor < ActiveRecord::Migration[5.2]
  def change
    add_column :app_monitors, :latest_result_id, :integer
  end
end
