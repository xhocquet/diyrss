class AddDashboardSlugToUserProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :user_profiles, :dashboard_slug, :string
    add_index :user_profiles, :dashboard_slug, unique: true
  end
end
