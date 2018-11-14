class BlockUserDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    {
      id: banned_user.id,
      name: banned_user.name,
      status: 'Banned',
      information: information(banned_user),
      wall: banned_user.wall,
      groups: banned_user.groups.count,
      friends: banned_user.friends.count,
      subscribers: banned_user.subscribers.count,
      videos: banned_user.videos.count,
      photos: banned_user.photos.count,
      audios: banned_user.audios.count
    }
  end

  def banned_user
    subscriber = User.find(blocked_id).decorate
  end

  def information(object)
    {
      email: object.email,
      number: object.number,
      bday: object.date,
      relation: [relations, relations],
      address: object.address,
      location: [object.country, object.locate].join(', '),
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
