class FriendDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    if context[:create]
      {
        id: friend.id,
        name: friend.name,
        status: 'Friend'
      }
    else
      {
        id: friend.id,
        name: friend.name,
        status: 'Friend',
        information: information(friend),
        wall: friend.wall,
        groups: friend.groups.count,
        friends: friend.friends.count,
        subscribers: friend.subscribers.count,
        videos: friend.videos.count,
        photos: friend.photos.count,
        audios: friend.audios.count
      }
    end
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

  def friend
    subscriber = User.find(friend_id).decorate
  end

end
