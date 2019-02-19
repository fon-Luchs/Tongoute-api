class Api::SubscribingsController < BaseController
  
  include Relatable
  
  before_action :build_resource, only: :create
  
  helper_method :friend_request?, :current_id

  def destroy
    relation_finder(current_user).subscribings.delete get_object
    head 204 unless relation_finder(current_user).subscribers.exists?(relating_id: get_object.id)
  end

  private

  def build_resource
    @subscribed = current_user.relations.new(related_id: get_object.id)
  end

  def resource
    @subscribed ||= get_object
  end

  def collection
    @subscibing = relation_finder(current_user).subscribings
  end

  def get_object
    @user = relation_finder(current_user).subscribings.find(params[:subscribing_id]) if params[:subscribing_id]
    @user = relation_finder(current_user).subscribings.find(params[:id]) if params[:id]
    @user = User.find(params[:user_id]) if params[:user_id]
    @user
  end

  def friend_request?
    relation_finder(current_user).friends.exists?(relating_id: get_object.id)
  end

  def banned?
    relation_finder(set_user).blocked_users.exists?( related_id: params[:id] )
  end

  def current_id
    current_user.id
  end
end
