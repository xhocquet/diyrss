class CreateLinkMonitors < ActiveRecord::Migration[5.2]
  def change
    create_table :app_monitors do |t|
      t.text :url, required: true, blank: false, index: true
      t.integer :status, default: 0

      t.timestamps
    end

    create_table :user_monitors do |t|
      t.text :name
      t.text :url
      t.integer :status, default: 0

      t.references :app_monitor, required: true, index: true
      t.references :user, required: true, index: true
      t.references :user_category, required: true, index: true

      t.timestamps
    end

    create_table :user_categories do |t|
      t.text :name, required: true, blank: false

      t.references :user, required: true, index: true

      t.timestamps
    end
  end
end
