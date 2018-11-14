class Api::BlockUsersController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @block_user = current_user.block_users.new(resource_params)
  end

  def resource
    @block_user ||= current_user.block_users.find(params[:id])
  end

  def collection
    @block_users = current_user.block_users
  end

  def resource_params
    { blocked_id: get_user_for_block.id }
  end

  def get_user_for_block
    @b_user if @b_user
    @b_user = User.find(params[:subscriber_id]) if params[:subscriber_id]
    @b_user = User.find(params[:friend_id]) if params[:friend_id]
    @b_user = User.find(params[:user_id]) if params[:user_id]
    @b_user
  end
end
