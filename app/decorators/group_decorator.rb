class GroupDecorator < Draper::Decorator
  delegate_all

  # decorates_associations :users

  decorates_associations :wall

  def as_json(*args)
    if context[:group_index]
      {
        id: object.id,
        name: object.name,
        author: {
          id: author.id,
          name: author.name
        }
      }

    elsif context[:group_show]
      {
        id: object.id,
        name: object.name,
        author: {
          id: author.id,
          name: author.name
        },
        users: users,
        wall: wall
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
