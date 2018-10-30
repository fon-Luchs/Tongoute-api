class UserDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    params.select { |key, value| @context.key? key }
  end

  def params
    {
      id: object.id,
      name: name,
      groups: 2,
      friends: 4,
      videos: 8,
      photos: 16,
      audios: 32,
      information: info
    }
  end

  def name
    [first_name, last_name].join(' ')
  end

  def info
    {
      email: object.email,
      number: object.number,
      bday: object.date,
      address: object.address,
      relation: [relations, relations],
      about_self: object.about
    }
  end

  def relations
    {
      id: 23,
      name: 'Jarry Smith',
      relations: 'Best friend'
    }
  end
end
