module U
  class PublicDashboardsController < BaseController
    skip_before_action :authenticate_user!

    def show
      @user_profile = UserProfile.find_by(dashboard_slug: params[:slug])
      @user_categories = @user_profile.user.user_categories.includes(user_monitors: :app_monitor) || []
      render 'public/dashboard'
    end
  end
end
