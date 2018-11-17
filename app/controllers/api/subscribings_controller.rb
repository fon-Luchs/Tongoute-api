class Api::SubscribingsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @user = User.find(params[:user_id])
    @subscribed = current_user.active_relationship.new(subscribed_id: @user.id)
  end

  def resource
    @subscribed ||= current_user.subscribing.find(params[:subscribed_id])
  end

  def collection
    @subscibing = current_user.subscribing
  end
end
