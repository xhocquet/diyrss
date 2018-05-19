class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_categories, inverse_of: :user
  has_many :user_monitors, inverse_of: :user
  has_many :app_monitors, through: :user_monitors
  has_many :notifications, inverse_of: :recipient, foreign_key: "recipient_id"

  has_one :user_profile
end
