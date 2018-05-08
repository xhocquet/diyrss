class UserMonitorsController < ActionController::Base
  protect_from_forgery with: :exception

  def create
    monitor = user_category.user_monitors.new(create_params)

    if monitor.save
      flash[:notice] = "Successfully created link monitor."
    else
      flash[:alert] = "Could not create link monitor, Try again."
      flash[:error] = "#{monitor.errors.full_messages.first}"
    end

    redirect_to root_path
  end

  def update
    if monitor.update update_params
      flash[:notice] = "Successfully updated link."
    else
      flash[:alert] = "Could not update link. Try again."
    end

    redirect_to root_path
  end

  def destroy
    if monitor.destroy
      flash[:notice] = "Successfully deleted link."
    else
      flash[:alert] = "Could not delete link. Try again."
    end

    redirect_to root_path
  end

  private

  def create_params
    params.require(:user_monitor).permit(:name, :url).merge(user: current_user, app_monitor: app_monitor)
  end

  def update_params
    params.require(:user_monitor).permit(:name, :url)
  end

  def user_category
    current_user.user_categories.find(params.require(:user_category_id))
  end

  def monitor
    current_user.user_monitors.find(params.require(:id))
  end

  def monitor_url
    params.require(:user_monitor).require(:url)
  end

  def app_monitor
    AppMonitor.find_or_create_by!(url: monitor_url)
  end
end
