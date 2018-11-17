class Api::SubscribersController < BaseController

  private

  def resource
    @subscriber = current_user.subscribers.find(params[:subscriber_id])
  end

  def collection
    @subscribers = current_user.subscribers
  end

end
