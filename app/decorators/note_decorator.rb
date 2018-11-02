class NoteDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    {
      id: object.id,
      title: object.title,
      body: object.body
    }
  end
end
