class Api::SubscribersController < BaseController
  before_action :build_resource, only: :create
  
  private

  def build_resource
    @user = User.find(params[:user_id])
    @subscriber = @user.subscribers.new(resource_params)
  end

  def resource
    @subscriber ||= current_user.subscribers.find(params[:id])
  end

  def collection
    @subscribers = \
      if params[:user_id]
        @user = User.find(params[:user_id])
        @subscribers = @user.subscribers
      else
        @subscribers = current_user.subscribers
      end
  end

  def resource_params
    { subscriber_id: current_user.id }
  end
end
