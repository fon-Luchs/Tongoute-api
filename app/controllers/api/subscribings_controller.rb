class Api::SubscribingsController < BaseController
  before_action :build_resource, only: :create
  helper_method :friend_request?

  private

  def build_resource
    @subscribed = current_user.active_relationship.new(subscribed_id: set_user.id)
  end

  def resource
    @subscribed ||= set_user
  end

  def collection
    @subscibing = current_user.subscribing
  end

  def set_user
    return @user if @user
    @user = current_user.subscribers.find(params[:subscriber_id]) if params[:subscriber_id]
    @user = current_user.subscribers.find(params[:id]) if params[:id]
    @user = User.find(params[:user_id]) if params[:user_id]
    @user = FriendFinder.new(current_user).find(params[:friend_id]) if params[:friend_id]
    @user
  end

  def friend_request?
    current_user.subscribers.include?(set_user)
  end
end
