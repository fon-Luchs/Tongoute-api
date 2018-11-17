class RelationshipDecorator < Draper::Decorator
  delegate_all
  decorates_associations :subscriber
  decorates_associations :subscribed

  def as_json(*args)
    if context[:subscriber_show]
    {
      id: subscriber.id,
      name: subscriber.name,
      status: 'Subscriber',
      information: subscriber.info,
      wall: subscriber.wall,
      groups: subscriber.groups.count,
      friends: subscriber.friends.count,
      subscribers: subscriber.subscribers.count,
      videos: subscriber.videos.count,
      photos: subscriber.photos.count,
      audios: subscriber.audios.count
    }

    elsif context[:subscriber_index]
    {  
      id: subscriber.id,
      name: subscriber.name,
      status: 'Subscriber'
    }

    elsif context[:subscribed_show]
    {
      id: subscribed.id,
      name: subscribed.name,
      status: 'Subscribed',
      information: subscribed.info,
      wall: subscribed.wall,
      groups: subscribed.groups.count,
      friends: subscribed.friends.count,
      subscribers: subscribed.subscribers.count,
      videos: subscribed.videos.count,
      photos: subscribed.photos.count,
      audios: subscribed.audios.count
    }

    elsif context[:subscribed_index]
    {
      id: subscribed.id,
      name: subscribed.name,
      status: 'Subscribed'
    }

    elsif context[:subscribed_create]
    {
      id: subscribed.id,
      name: subscribed.name,
      status: 'Friend request sended',
      information: subscribed.info,
      wall: subscribed.wall,
      groups: subscribed.groups.count,
      friends: subscribed.friends.count,
      subscribers: subscribed.subscribers.count,
      videos: subscribed.videos.count,
      photos: subscribed.photos.count,
      audios: subscribed.audios.count
    }
    end
  end
  
end