class ConversationDecorator < Draper::Decorator
  delegate_all
  decorates_associations :sender
  decorates_associations :recipient

  def as_json(*args)
    if context[:user_id] == sender.id
      {
        id: object.id,
        name: recipient.name,
        messages: [
          {
            name: 'Rudolf Gess',
            message: 'Hi dude!'
          },
  
          {
            name: 'Rudolf Gess',
            message: 'Heey?'
          }
        ]
      }
    elsif context[:user_id] == recipient.id
        {
          id: object.id,
          name: sender.name,
          messages: [
            {
              name: 'Rudolf Gess',
              message: 'Hi dude!'
            },
    
            {
              name: 'Rudolf Gess',
              message: 'Heey?'
            }
          ]
        }
    elsif context[:conversations_index]
      {
        id: object.id,
        name: context[:user_id] == sender.id ? sender.name : recipient.name
      }
    elsif context[:blocked]
      blocked
    end
  end

  def blocked
    {
      name: 'Migel Castoras',
        messages: [
          {
            name: 'Rudolf Gess',
            message: 'Hi dude!'
          },

          {
            name: 'Rudolf Gess',
            message: 'Heey?'
          }
        ]
    }
  end
end
