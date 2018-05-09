class AddSelectorToAppMonitor < ActiveRecord::Migration[5.2]
  def change
    add_column :app_monitors, :selector, :text
  end
end
