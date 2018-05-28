class CreateAppMonitorSelectorSelections < ActiveRecord::Migration[5.2]
  def change
    create_table :selector_suggestions do |t|
      t.references :app_monitor
      t.references :user
      t.text :selector

      t.timestamps
    end
  end
end
