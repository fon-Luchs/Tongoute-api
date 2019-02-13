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
    relation_finder(current_user).block_users.exists?( related_id: params[:id] )
  end
end
