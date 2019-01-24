class ConversationDecorator < Draper::Decorator
  delegate_all

  decorates_associations :sender
  decorates_associations :recipient
  decorates_associations :messages

  def as_json(*args)
    if context[:user_id] == sender.id
      {
        id: object.id,
        name: recipient.name,
        messages: object.messages.order(created_at: :asc).decorate.as_json
      }
    elsif context[:user_id] == recipient.id
        {
          id: object.id,
          name: sender.name,
          messages: object.messages.order(created_at: :asc).decorate.as_json
        }
    elsif context[:conversations_index]
      {
        id: object.id,
        name: context[:user_id] == sender.id ? sender.name : recipient.name,
        last_message: object.messages.decorate.last.as_json
      }
    elsif context[:blocked]
      blocked
    end
  end

  def blocked
    {
      name: 'Migel Castoras',
      messages: object.messages.order(created_at: :asc).decorate.as_json
    }
  end
end
