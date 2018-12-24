class Api::ConversationsController < BaseController
  before_action :build_resource, only: :create
  
  private

  def build_resource
    @conversation = current_user.active_conversations.new(resource_params)
  end

  def resource
    @conversation ||= conversations.find(conversation_params)
  end

  def collection
    @conversations ||= conversations
  end

  def resource_params
    params.permit().merge(recipient_id: params[:user_id])
  end

  def conversations
    @conversations = UserConversations.new(current_user).get_conversations
  end

  def conversation_params
    return @params if @params
    @params = params[:id] if params[:id]
    @params
  end

  def banned?
    BlackList.exists?(blocker_id: params[:user_id], blocked_id: current_user.id)
  end
end
