class ChatDecorator < Draper::Decorator
  delegate_all

  decorates_associations :users

  decorates_associations :messages

  def as_json(*args)
    if context[:chat_index]
      {
        id: object.id,
        name: object.name,
        author: {
          id: author.id,
          name: author.name
        },
        last_message: object.messages.decorate.last.as_json
      }

    elsif context[:chat_show]
      {
        id: object.id,
        name: object.name,
        author: {
          id: author.id,
          name: author.name
        },
        users: users,
        messages: object.messages.order(created_at: :asc).decorate.as_json
      }
    end
  end

  def users
    object.users.decorate(context: { index: true })
  end

  def author
    User.find(object.creator_id).decorate( context: {show: true} )
  end

end
