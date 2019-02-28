class Api::SubscribingsController < BaseController
  
  include Relatable
  
  before_action :build_resource, only: :create
  
  helper_method :friend_request?, :current_id

  private

  def build_resource
    @subscribed = current_user.relations.new(resource_params)
  end

  def resource
    @subscribed ||= get_object
  end

  def collection
    @subscibing = relation_finder(current_user).subscribings
  end

  def resource_params
    params.permit().merge(related_id: get_object.id)
  end

  def get_object
    @user = relation_finder(current_user).subscribings.find(params[:subscribing_id]) if params[:subscribing_id]
    @user = relation_finder(current_user).subscribings.find(params[:id]) if params[:id]
    @user = User.find(params[:user_id]) if params[:user_id]
    @user
  end

  def friend_request?
    relation_finder(current_user).friends.exists?(id: get_object.id)
  end

  def banned?
    ban = relation_finder(get_object).blocked_users.exists?(related_id: current_user.id) if params[:user_id]
    ban = relation_finder(User.find(get_object.initiated.id)).blocked_users.exists?(related_id: current_user.id) if params[:id]
    ban
  end

  def current_id
    current_user.id
  end
end
