class Api::ConversationsController < BaseController
  before_action :build_resource, only: :create

  helper_method :current_object

  private

  def build_resource
    @conversation = sender_object.active_conversations.new(resource_params)
  end

  def resource
    @conversation ||= collection.find(params[:id])
  end

  def collection
    @conversations = Conversation::ObjectConversations.call(sender_object)
  end

  def resource_params
    params.permit.merge(recipientable_id: recipient_object.id, recipientable_type: recipient_object.class.name )
  end

  def optional_params
    params.permit.merge(as_group_id: params[:as_group_id], as_group: params[:as_group])
  end

  def sender_object
    Conversation::InterlocutorSetter.new(params, optional_params, current_user).interlocutor_sender
  end

  def recipient_object
    Conversation::InterlocutorSetter.new(params, optional_params, current_user).interlocutor_recipient
  end

  def banned?
    false
  end

  def current_object
    Tools::PolymorphicData.call(sender_object)
  end
end
