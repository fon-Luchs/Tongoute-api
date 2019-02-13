class Api::SubscribersController < BaseController

  include Relatable

  private

  def resource
    @subscriber = relation_finder(set_user).subscribers.find(related_id: params[:id])
  end

  def collection
    @subscribers = relation_finder(set_user).subscribers
  end

  def set_user
    return @user if @user
    @user = User.find(params[:user_id]) if params[:user_id]
    @user ||= current_user
  end

  def banned?
    relation_finder(set_user).block_users.exists?( related_id: params[:id] )
  end
end
