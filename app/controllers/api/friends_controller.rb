class Api::FriendsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @friendship = current_user.friends.new(resource_params)
  end

  def resource
    @friendship ||= current_user.friends.find(params[:id])
  end

  def collection
    @friendship = Friend.all
  end

  def resource_params
    { friend_id: subscriber }
  end

  def subscriber
    return @subscriber if @subscriber
    @subscriber_id = params[:subscriber_id] if params[:subscriber_id]
    @subscriber_id = params[:user_id] if params[:user_id]
  end
end
