require "administrate/base_dashboard"

class AppMonitorDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    monitor_results: Field::HasMany,
    user_monitors: Field::HasMany,
    users: Field::HasMany,
    id: Field::Number,
    url: Field::Text,
    status: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    selector: Field::Text,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :url,
    :selector,
    :users,
    :monitor_results,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :url,
    :status,
    :created_at,
    :updated_at,
    :selector,
    :users,
    :user_monitors,
    :monitor_results,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :url,
    :selector,
  ].freeze

  # Overwrite this method to customize how app monitors are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(app_monitor)
  #   "AppMonitor ##{app_monitor.id}"
  # end
end
