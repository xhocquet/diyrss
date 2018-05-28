module CurrentUser
  class SelectorSuggestionsController < BaseController
    def new
      @app_monitor = AppMonitor.find_by(id: params.require(:monitorId))
      @suggestion = SelectorSuggestion.new(app_monitor: @app_monitor, user: current_user)
    end

    def create
      @suggestion = current_user.selector_suggestions.new(suggestion_params)

      if verify_recaptcha(model: @suggestion) && @suggestion.save
        flash[:notice] = "Successfully submitted suggestion!"
        redirect_to current_user_selector_suggestions_success_path
      else
        flash[:alert] = "Could not save suggestion. Try again."
        render :new
      end

    end

    def suggestion_params
      params.require(:selector_suggestion).permit(:app_monitor_id, :selector).merge({ user_id: current_user.id })
    end
  end
end
