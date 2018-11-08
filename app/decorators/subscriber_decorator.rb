class SubscriberDecorator < Draper::Decorator
  delegate_all
  decorates_associations :user

  def as_json(*args)
    if context[:create]
      {
        id: user.id,
        name: user.name,
        status: 'Friendship request sended',
        information: information(user),
        wall: user.wall,
        groups: user.groups.count,
        friends: user.friends.count,
        videos: user.videos.count,
        photos: user.photos.count,
        audios: user.audios.count
      }
    
    elsif context[:index]
      {
        id: user.id,
        name: user.name,
        status: 'Subscriber'
      }

    else
      {
        id: subscriber.id,
        name: subscriber.name,
        status: 'Subscriber',
        information: information(subscriber),
        wall: subscriber.wall,
        groups: subscriber.groups.count,
        friends: subscriber.friends.count,
        videos: subscriber.videos.count,
        photos: subscriber.photos.count,
        audios: subscriber.audios.count
      }
    end
  end

  def subscriber
    subscriber = User.find(subscriber_id).decorate
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
