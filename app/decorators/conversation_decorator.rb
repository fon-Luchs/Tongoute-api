class ConversationDecorator < Draper::Decorator
  delegate_all

  decorates_associations :senderable
  decorates_associations :recipientable
  decorates_associations :messages

  def as_json(*args)
    if context[:id] == senderable.id && context[:type] == object.senderable_type
      {
        id: object.id,
        interlocutor: interlocutor(recipientable, object.recipientable_type),
        messages: object.messages.order(created_at: :asc).decorate.as_json
      }

    elsif context[:id] == recipientable.id && context[:type] == object.recipientable_type
      {
        id: object.id,
        interlocutor: interlocutor(senderable, object.senderable_type),
        messages: object.messages.order(created_at: :asc).decorate.as_json
      }

    elsif context[:conversations_index]
      params = context[:conversations_index]
      {
        id: object.id,
        interlocutor: index_comparison(params, senderable, object.senderable_type) ? interlocutor(recipientable, object.recipientable_type) : interlocutor(senderable, object.senderable_type),
        last_message: object.messages.decorate.last.as_json
      }
    end
  end

  def index_comparison(params, conversationable_object, type)
    params[:id] == conversationable_object.id && params[:type] == type
  end

  def interlocutor(conversationable_object, type)
    {
      id: conversationable_object.id,
      name: conversationable_object.name,
      type: type
    }
  end
end
