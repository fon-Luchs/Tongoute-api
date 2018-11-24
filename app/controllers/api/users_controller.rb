class Api::UsersController < BaseController
  helper_method :banned?

  private

  def resource
    @user = User.find(params[:id])
  end

  def collection
    @users = User.all
  end

  def banned?
    BlackList.exists?(blocker_id: params[:id], blocked_id: current_user.id)
  end
end
