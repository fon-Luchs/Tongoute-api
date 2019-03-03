class WallDecorator < Draper::Decorator
  delegate_all
  decorates_associations :wallable
  decorates_associations :posts

  def as_json(*args)
    if [:user_wall]
      {
        id: object.id,
        owner: {
          id: wallable.id,
          name: wallable.name
        },

        posts: posts.as_json
      }
    elsif[:group_wall]
    end
  end

end
