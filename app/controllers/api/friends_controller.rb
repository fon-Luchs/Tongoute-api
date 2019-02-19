class Api::FriendsController < BaseController
  
  include Relatable
  
  helper_method :current_id

  private

  def resource
    @friend = set_resource
  end

  def collection
    @friends = relation_finder(set_user).friends
  end

  def set_user
    params[:user_id] ? User.find(params[:user_id]) : current_user
  end

  def set_resource
    relation_finder(set_user).friends.find(params[:id]) if params[:id]
    relation_finder(set_user).friends.find(params[:friend_id]) if params[:friend_id]
  end

  def banned?
    relation_finder(set_user).blocked_users.exists?( related_id: params[:user_id] )
  end

  def current_id
    current_user.id
  end
end
