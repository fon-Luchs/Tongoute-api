class PostDecorator < Draper::Decorator
  delegate_all
  decorates_associations :user

  def as_json(*args)
    {
      id: object.id,
      title: object.title,
      body: object.body,
      author: author,
      likes: 332
    }
  end

  def author
    {
      id: user.id,
      name: user.name
    }
  end
end
