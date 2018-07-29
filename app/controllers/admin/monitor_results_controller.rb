module Admin
  class MonitorResultsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    def scoped_resource
      resource_class.order(created_at: :desc)
    end

    def diff
      @resource = scoped_resource.find(params.require(:monitor_result_id))
      @diff = @resource.difference_from_last_in_html
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   MonitorResult.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
