class Api::SubscribingsController < BaseController
  
  include Relatable
  
  before_action :build_resource, only: :create
  
  helper_method :friend_request?

  def destroy
    relation_finder(current_user).subscribing.delete set_user
    head 204 unless current_user.subscribing.include? set_user
  end

  private

  def build_resource
    @subscribed = current_user.relations.new(related_id: set_user.id)
  end

  def resource
    @subscribed ||= relation_finder(set_user)
  end

  def collection
    @subscibing = relation_finder(current_user).subscribing
  end

  def set_user
    return @user if @user
    @user = relation_finder(current_user).subscribers.find(params[:subscriber_id]) if params[:subscriber_id]
    @user = relation_finder(current_user).subscribing.find(params[:subscribing_id]) if params[:subscribing_id]
    @user = relation_finder(current_user).subscribing.find(params[:id]) if params[:id]
    @user = User.find(params[:user_id]) if params[:user_id]
    @user = relation_finder(current_user).friends.find(params[:friend_id]) if params[:friend_id]
    @user
  end

  def friend_request?
    current_user.subscribers.include?(set_user)
  end

  def banned?
    current_reletions.block_users.exists?( related_id: params[:id] )
  end
end
