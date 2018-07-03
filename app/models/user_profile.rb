class UserProfile < ApplicationRecord
  belongs_to :user

  validates :dashboard_slug, uniqueness: true
end
