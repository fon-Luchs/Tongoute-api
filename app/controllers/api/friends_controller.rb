class Api::FriendsController < BaseController
  before_action :build_resource, only: :create

  private

  def resource
    @friend ||= FriendFinder.new(set_user).find(params[:id])
  end

  def collection
    @friends = FriendFinder.new(set_user).all
  end

  def set_user
    return @user if @user
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end

  def banned?
    BlackList.exists?(blocker_id: params[:id], blocked_id: current_user.id)
  end
end
