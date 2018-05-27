class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_categories, inverse_of: :user, dependent: :destroy
  has_many :user_monitors, inverse_of: :user
  has_many :app_monitors, through: :user_monitors
  has_many :notifications, inverse_of: :recipient, foreign_key: "recipient_id", dependent: :destroy

  has_one :user_profile

  after_create :create_loan_profile

  enum role: {
    user: 0,
    admin: 1,
  }

  def create_loan_profile
    return if loan_profile.present?

    LoanProfile.create! user: self
  end
end
