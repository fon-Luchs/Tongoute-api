class Api::WallsController < BaseController

  include Relatable

  private

  def resource
    @wall = set_user.wall
  end

  def banned?
    head 403 if relation_finder(set_user).blocked_users.exists?( related_id: current_user.id ) 
  end

  def set_user
    user = User.find(params[:user_id]) if params[:user_id]
    user ||= current_user
    user
  end
end
