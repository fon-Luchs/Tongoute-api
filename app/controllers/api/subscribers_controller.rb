class Api::SubscribersController < BaseController

  private

  def resource
    @subscriber = set_user.subscribers.find(params[:id])
  end

  def collection
    @subscribers = set_user.subscribers
  end

  def set_user
    return @user if @user
    @user = User.find(params[:user_id]) if params[:user_id]
    @user ||= current_user
  end

  def banned?
    BlackList.exists?(blocker_id: params[:id], blocked_id: current_user.id)
  end
end
