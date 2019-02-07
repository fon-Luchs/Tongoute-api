class RelationDecorator < Draper::Decorator

  include Relatable

  delegate_all
  decorates_associations :initiator
  decorates_associations :initiated

  def as_json(*args)
    if context[:block_show]
      {
        id: object.id,
        name: name,
        status: 'Banned',
        information: info,
        wall: wall,
        groups: groups.count,
        friends: friends.count,
        subscribers: subscribers.count,
        videos: videos.count,
        photos: photos.count,
        audios: audios.count
      }

    elsif context[:block_index]
      {
        id: object.id,
        name: name,
        status: 'Banned'
      }

      elsif context[:subscriber_show]
      {
        id: object.id,
        name: initiator.name,
        status: 'Subscriber',
        information: initiator.info,
        wall: initiator.wall,
        groups: initiator.groups.count,
        friends: friends.count,
        subscribers: subscribers.count,
        videos: initiator.videos.count,
        photos: initiator.photos.count,
        audios: initiator.audios.count
      }

      elsif context[:subscriber_index]
      {  
        id: object.id,
        name: name,
        status: 'Subscriber'
      }

      elsif context[:subscribed_show]
      {
        id: object.id,
        name: initiated.name,
        status: 'Subscribed',
        information: initiated.info,
        wall: initiated.wall,
        groups: initiated.groups.count,
        friends: friends.count,
        subscribers: subscribers.count,
        videos: initiated.videos.count,
        photos: initiated.photos.count,
        audios: initiated.audios.count
      }

      elsif context[:subscribed_index]
      {
        id: object.id,
        name: initiated.name,
        status: 'Subscribed'
      }

      elsif context[:friend_show]
      {
        id: object.id,
        name: name,
        status: 'Friend',
        information: info,
        wall: wall,
        groups: groups.count,
        friends: friends.count,
        subscribers: subscribers.count,
        videos: videos.count,
        photos: photos.count,
        audios: audios.count
      }

      elsif context[:friend_index]
      {
        id: object.id,
        name: name,
        status: 'Friend'
      }

      else
      {
        id: object.id,
        name: name,
        status: 'Subscriber'
      }  
      end  
    end

  def friends
    relation_finder(self).friends.decorate(context: {friend_index: true})
  end

  def subscribers
    relation_finder(self).subscribers.decorate(context: {subscriber_index: true})
  end

  def subscribing
    relation_finder(self).subscribing.decorate(context: {subscribed_index: true})
  end

  def blocking
    relation_finder(self).blocking.decorate(context: {block_index: true})
  end

end