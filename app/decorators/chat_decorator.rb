class ChatDecorator < Draper::Decorator
  delegate_all

  decorates_associations :users

  def as_json(*args)
    if context[:chat_index]
      {
        id: object.id,
        name: object.name,
        author: {
          id: author.id,
          name: author.name
        },
        last_message: 'LOL'
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
        messages: [{context: 'lol'}]
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
