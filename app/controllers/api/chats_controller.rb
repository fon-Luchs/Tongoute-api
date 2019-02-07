class Api::ChatsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @chat = Chat.new(resource_params.merge(creator_id: current_user.id))
    @chat.users << current_user
    @chat
  end

  def resource
    @chat ||= current_user.chats.find(params[:id])
  end

  def collection
    @chats = current_user.chats
  end

  def resource_params
    params.require(:chat).permit(:name)
  end
end
