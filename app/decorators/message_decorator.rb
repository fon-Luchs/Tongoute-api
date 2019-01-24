class MessageDecorator < Draper::Decorator
  delegate_all
  decorates_associations :user

  def as_json(*args)
    {
      author: {
        id: user.id,
        name: user.name
      },
      
      id: object.id,
      text: object.text
    }
  end

end
