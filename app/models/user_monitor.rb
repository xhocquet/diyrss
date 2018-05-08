class UserMonitor < ApplicationRecord
  belongs_to :app_monitor, inverse_of: :user_monitors
  belongs_to :user, inverse_of: :user_monitors
  belongs_to :user_category, inverse_of: :user_monitors

  enum status: [
    :fresh,
    :stale,
  ]
end
