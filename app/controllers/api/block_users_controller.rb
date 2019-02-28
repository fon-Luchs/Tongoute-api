class Api::BlockUsersController < BaseController

  include Relatable

  before_action :build_resource, only: :create

  def destroy
    relation_finder(current_user).blocked_users.delete set_user
    head 204
  end

  private

  def build_resource
    @block_user = current_user.relations.new(build_params)
  end

  def resource
    @block_user ||= set_user
  end

  def collection
    @block_users = relation_finder(current_user).blocked_users
  end

  def build_params
    resource_params.merge(related_id: set_user.id)
  end

  def resource_params
    params.permit().merge(state: 2)
  end

  def set_user
    @b_user = relation_finder(current_user).friends.find(params[:friend_id]) if params[:friend_id]
    @b_user = relation_finder(current_user).blocked_users.find(params[:id]) if params[:id]
    @b_user = User.find(params[:user_id]) if params[:user_id]
    @b_user
  end

  def banned?
    ban = relation_finder(set_user).blocked_users.exists?(related_id: current_user.id) if params[:user_id]
    ban = relation_finder(User.find(resource.initiator.id)).blocked_users.exists?(related_id: current_user.id) if params[:friend_id] || params[:id]
    ban
  end
end
