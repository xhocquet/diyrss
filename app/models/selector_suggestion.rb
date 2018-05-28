class SelectorSuggestion < ApplicationRecord
  belongs_to :app_monitor, inverse_of: :selector_suggestions
  belongs_to :user, inverse_of: :selector_suggestions

  validates :selector, presence: :true
end
