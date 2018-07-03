module CurrentUser
  class ProfilesController < BaseController
    def show
      @user = current_user
      @profile = UserProfile.find_or_create_by(
        user: current_user,
      )
    end

    def update
      if current_user.user_profile.update profile_params
        flash[:notice] = "Successfully saved profile!"
      else
        flash[:error] = "We had a little trouble, please try again!"
      end

      redirect_to current_user_profile_path
    end

    def profile_params
      params.require(:user_profile).permit(:notify_email, :notify_site, :dashboard_slug)
    end
  end
end
