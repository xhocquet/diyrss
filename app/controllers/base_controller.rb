class BaseController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'
end
