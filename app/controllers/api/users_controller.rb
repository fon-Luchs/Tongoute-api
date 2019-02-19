class Api::UsersController < BaseController
  
  include Relatable
  
  helper_method :banned?

  private

  def resource
    @user = User.find(params[:id])
  end

  def collection
    @users = User.all
  end

  def banned?
    relation_finder(User.find(params[:id])).blocked_users.exists?( related_id: current_user.id )
  end
end
