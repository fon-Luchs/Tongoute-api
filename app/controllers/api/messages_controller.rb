class Api::MessagesController < BaseController
  before_action :build_resource, only: :create

  def create
    banned? ? head(204) : super
  end

  private

  def build_resource
    @message = parent.messages.new(resource_params)
  end

  def resource
    @message ||= Message::MessageResource.call(current_user, parent)
  end

  def resource_params
    params.require(:message).permit(:text).merge(user_id: current_user.id)
  end

  def parent
    Message::MessageParent.call(params)
  end

  def banned?
    false
  end
end
