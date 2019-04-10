class Api::ChatsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @chat = builder.build
  end

  def resource
    @chat ||= current_user.chats.find(params[:id])
  end

  def collection
    @chats = current_user.chats
  end

  def build_params
    resource_params.merge(creator_id: current_user.id)
  end

  def resource_params
    params.require(:chat).permit(:name)
  end

  def builder
    Tools::ThroughJoinBuilder.new(klass: Chat, c_user: current_user, params: build_params)
  end
end
