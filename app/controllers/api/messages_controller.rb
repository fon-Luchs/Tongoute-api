class Api::MessagesController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @message = set_parent.messages.new(resource_params)
  end

  def resource
    @message ||= Message.find_by!(user_id: current_user.id, messageable_id: set_parent.id, messageable_type: set_parent.class.name)
  end

  def resource_params
    params.require(:message).permit(:text).merge(user_id: current_user.id)
  end

  def set_parent
    @parent = Chat.find(params[:chat_id]) if params[:chat_id]
    @parent = Conversation.find(params[:conversation_id]) if params[:conversation_id]
    @parent
  end
end
