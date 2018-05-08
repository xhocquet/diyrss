class CreateMoreBaseModels < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id, required: true, null: false, index: true

      t.integer :action, default: 0

      t.integer :relevant_thing_id
      t.string :relevant_thing_type

      t.datetime :read_at
      t.timestamps
    end

    create_table :monitor_results do |t|
      t.references :app_monitor, index: true
      t.text :payload

      t.integer :status, default: 1

      t.timestamps
    end
  end
end
