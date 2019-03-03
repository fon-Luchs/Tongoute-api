class PostDecorator < Draper::Decorator
  delegate_all
  decorates_associations :postable

  def as_json(*args)
    {
      id: object.id,
      body: object.body,
      author: author,
      likes: 332
    }
  end

  def author
    {
      id: postable.id,
      name: postable.name
    }
  end
end
