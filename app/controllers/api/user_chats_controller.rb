class Api::UserChatsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @user_chat = UserChat.find_or_initialize_by(resource_params.merge(role: 0))
  end

  def resource
    @user_chat ||= UserChat.find_by!(default_params)
  end

  def resource_params
    params.permit().merge(default_params)
  end

  def default_params
    chat = Chat.find(params[:chat_id])
    { chat_id: chat.id, user_id: current_user.id }
  end
end
