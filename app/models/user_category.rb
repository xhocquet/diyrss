class UserCategory < ApplicationRecord
  belongs_to :user, inverse_of: :user_categories

  has_many :user_monitors, inverse_of: :user_category, dependent: :destroy
end
