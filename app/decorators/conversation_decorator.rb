class ConversationDecorator < Draper::Decorator
  delegate_all
  decorates_associations :sender
  decorates_associations :recipient

  def as_json(*args)
    if context[:conversations_show]
      {
        id: object.id,
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
    elsif context[:conversations_index]
      conversations
    elsif context[:blocked]
      blocked
    end
  end

  def conversations
    [
      {
        name: 'Astor Piyazola',
        last_message: 'lool'
      },

      {
        name: 'Bon Piranno',
        last_message: 'lool'
      }
    ]
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
