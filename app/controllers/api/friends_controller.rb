class Api::FriendsController < BaseController
  before_action :build_resource, only: :create

  private

  def resource
    @friend ||= FriendFinder.new(current_user).find(set_user)
  end

  def collection
    @friends = FriendFinder.new(current_user).all
  end

  def set_user
    return @user if @user
    @user = current_user.subscribers.find(params[:subscriber_id]) if params[:subscriber_id]
    @user = current_user.subscribers.find(params[:user_id]) if params[:user_id]
    @user = current_user.subscribers.find(params[:id]) if params[:id]
    @user = current_user.subscribers.find(params[:friend_id]) if params[:friend_id]
    @user
  end
end
