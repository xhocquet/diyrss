class AddLastViewedResultsToUserMonitor < ActiveRecord::Migration[5.2]
  def change
    add_column :user_monitors, :last_viewed_result_id, :integer
  end
end
