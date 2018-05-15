class AddLastViewedToUsermonitor < ActiveRecord::Migration[5.2]
  def change
    add_column :user_monitors, :last_viewed, :datetime
  end
end
