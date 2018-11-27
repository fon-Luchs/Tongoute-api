class Api::BlockUsersController < BaseController
  before_action :build_resource, only: :create

  def destroy
    current_user.blocking.delete set_user
    head 204
  end

  private

  def build_resource
    @block_user = current_user.active_block.new(resource_params)
  end

  def resource
    @block_user ||= set_user
  end

  def collection
    @block_users = current_user.blocking
  end

  def resource_params
    { blocked_id: set_user.id }
  end

  def set_user
    @b_user if @b_user
    @b_user = current_user.subscribers.find(params[:subscriber_id]) if params[:subscriber_id]
    @b_user = FriendFinder.new(current_user).find(params[:friend_id]) if params[:friend_id]
    @b_user = User.find(params[:user_id]) if params[:user_id]
    @b_user = current_user.blocking.find(params[:id]) if params[:id]
    @b_user
  end
end
