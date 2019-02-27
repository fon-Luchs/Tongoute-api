class Api::ConversationsController < BaseController
  
  include Relatable
  
  before_action :build_resource, only: :create

  helper_method :current_id

  private

  def build_resource
    @conversation = current_user.active_conversations.new(resource_params)
  end

  def resource
    @conversation ||= conversations.find(params[:id])
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

  def banned?
    res = relation_finder(get_interlocutor).blocked_users.exists?(related_id: current_user.id) if params[:id] || params[:user_id]
    res
  end

  def get_interlocutor
    id = resource.sender_id == current_id ? resource.recipient_id : resource.sender_id
    User.find(id)
  end

  def current_id
    current_user.id
  end
end
