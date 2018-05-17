class UserCategoriesController < BaseController
  def create
    category = current_user.user_categories.create(create_params)

    if category.valid?
      flash[:notice] = "Successfully created category."
    else
      flash[:alert] = "Could not create category. Try again."
    end

    redirect_to root_path
  end

  def destroy
    if current_category.destroy
      flash[:notice] = "Successfully deleted category."
    else
      flash[:alert] = "Could not delete category. Try again."
    end

    redirect_to root_path
  end

  def create_params
    params.require(:user_category).permit(:name)
  end

  def destroy_param
    params.require(:id)
  end

  def current_category
    current_user.user_categories.find(destroy_param)
  end
end
