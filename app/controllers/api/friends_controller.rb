class Api::FriendsController < BaseController
  
  include Relatable
  
  helper_method :current_id

  before_action :build_resource, only: :create

  private

  def build_resource
    @friend = current_user.relations.new(resource_params)
  end

  def resource
    @friend ||= set_resource
  end

  def collection
    @friends = relation_finder(set_user).friends
  end

  def set_user
    params[:user_id] ? User.find(params[:user_id]) : current_user
  end

  def resource_params
    params.permit().merge(related_id: set_resource.initiator.id)
  end

  def set_resource
    res = relation_finder(set_user).friends.find(params[:id]) if params[:id]
    res = relation_finder(set_user).friends.find(params[:friend_id]) if params[:friend_id]
    res = relation_finder(set_user).subscribers.find(params[:subscriber_id]) if params[:subscriber_id]
    res
  end

  def banned?
    res = relation_finder(User.find(set_user.initiator.id)).blocked_users.exists?(related_id: current_user.id) if params[:friend_id]
    res = relation_finder(User.find(set_user.initiator.id)).blocked_users.exists?(related_id: current_user.id) if params[:user_id]
    res
  end

  def current_id
    current_user.id
  end
end
