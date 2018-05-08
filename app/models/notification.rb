class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :relevant_thing, polymorphic: true

  enum action: {
    monitor_update: 0,
  }

  scope :unread, -> { where(read_at: nil) }
end
