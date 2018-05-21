class AddIndices < ActiveRecord::Migration[5.2]
  def change
    add_index :app_monitors, :latest_result_id
    add_index :user_monitors, [:app_monitor_id, :user_id], unique: true
    add_index :user_monitors, :last_viewed_result_id
  end
end
