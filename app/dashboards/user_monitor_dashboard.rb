require "administrate/base_dashboard"

class UserMonitorDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    app_monitor: Field::BelongsTo,
    user: Field::BelongsTo,
    user_category: Field::BelongsTo,
    id: Field::Number,
    name: Field::Text,
    url: Field::Text,
    status: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :app_monitor,
    :user,
    :user_category,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :app_monitor,
    :user,
    :user_category,
    :id,
    :name,
    :url,
    :status,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :app_monitor,
    :user,
    :user_category,
    :name,
    :url,
    :status,
  ].freeze

  # Overwrite this method to customize how user monitors are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user_monitor)
  #   "UserMonitor ##{user_monitor.id}"
  # end
end
