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
    end
  end
  
end