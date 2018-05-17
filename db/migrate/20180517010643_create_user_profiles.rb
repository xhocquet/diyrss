class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.boolean :notify_email, default: true
      t.boolean :notify_site, default: true

      t.references :user, null: false

      t.timestamps
    end
  end
end
