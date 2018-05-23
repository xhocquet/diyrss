class AddDifferentFlagToMonitorResult < ActiveRecord::Migration[5.2]
  def change
    add_column :monitor_results, :new_content, :boolean, default: false
  end
end
