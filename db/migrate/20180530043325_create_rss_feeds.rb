class CreateRssFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :rss_feeds do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.string :url

      t.timestamps
    end

    create_table :rss_feeds_user_monitors do |t|
      t.references :rss_feed
      t.references :user_monitor

      t.timestamps
    end
  end
end
