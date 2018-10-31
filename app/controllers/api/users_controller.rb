class Api::UsersController < BaseController
  private

  def resource
    @user = User.find(params[:id])
  end

  def collection
    @users = User.all
  end
end
