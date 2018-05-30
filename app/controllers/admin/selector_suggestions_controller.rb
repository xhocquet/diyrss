module Admin
  class SelectorSuggestionsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = AppMonitor.
    #     page(params[:page]).
    #     per(10)
    # end

    def confirm
      selector_suggestion = SelectorSuggestion.find(params.require(:selector_suggestion_id))
      # todo when I add status enums
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   AppMonitor.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
