class Api::SubscribersController < BaseController

  include Relatable

  private

  def resource
    @subscriber = relation_finder(set_user).subscribers.find(params[:id])
  end

  def collection
    @subscribers = relation_finder(set_user).subscribers
  end

  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
    @user ||= current_user
  end

  def banned?
    relation_finder(User.find(resource.initiated.id)).blocked_users.exists?(related_id: current_user.id) if params[:id]
  end
end
