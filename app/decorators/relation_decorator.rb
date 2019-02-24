class RelationDecorator < Draper::Decorator

  include Relatable

  delegate_all
  decorates_associations :initiator
  decorates_associations :initiated

  def as_json(*args)
    if context[:block_show]
      {
        id: object.id,
        status: object.state,
        user: {
          id: initiated.id,
          name: initiated.name,
          information: initiated.info,
          wall: initiated.wall,
          groups: initiated.groups.count,
          friends: friends.count,
          subscribers: subscribers.count,
          videos: initiated.videos.count,
          photos: initiated.photos.count,
          audios: initiated.audios.count
        }
        
      }

    elsif context[:block_index]
      {
        id: object.id,
        status: object.state,
        user: {
          id: initiated.id,
          name: initiated.name
        }
      }

    elsif context[:blocked]
      {
        id: object.id,
        status: 'This user add you in black list',
        user: {
          id: initiated.id,
          name: initiated.name
        }
      }

    elsif context[:subscriber_show]
      {
        id: object.id,
        status: object.state,
        user: {
          id: initiator.id,
          name: initiator.name,
          information: initiator.info,
          wall: initiator.wall,
          groups: initiator.groups.count,
          friends: friends.count,
          subscribers: subscribers.count,
          videos: initiator.videos.count,
          photos: initiator.photos.count,
          audios: initiator.audios.count
        }
      }

    elsif context[:subscriber_index]
      {  
        id: object.id,
        status: object.state,
        user: {
          id: initiator.id,
          name: initiator.name
        }
      }

    elsif context[:subscribed_show]
      {
        id: object.id,
        status: 'subscribed',
        user: {
          id: initiated.id,
          name: initiated.name,
          information: initiated.info,
          wall: initiated.wall,
          groups: initiated.groups.count,
          friends: friends.count,
          subscribers: subscribers.count,
          videos: initiated.videos.count,
          photos: initiated.photos.count,
          audios: initiated.audios.count
        }  
      }

    elsif context[:subscribed_index]
      {
        id: object.id,
        status: 'subscribed',
        user: {
          id: initiated.id,
          name: initiated.name
        }
      }

    elsif context[:friend_show]
      {
        id: object.id,
        status: object.state,
        user: {
          id: current_friend.id,
          name: current_friend.name,
          information: current_friend.info,
          wall: current_friend.wall,
          groups: current_friend.groups.count,
          friends: friends.count,
          subscribers: subscribers.count,
          videos: current_friend.videos.count,
          photos: current_friend.photos.count,
          audios: current_friend.audios.count
        }  
      }

    elsif context[:friend_index]
      {
        id: object.id,
        status: object.state,
        user: {
          id: current_friend.id,
          name: current_friend.name
        }
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

  def current_friend
    context[:friend_id] == initiator.id ? initiated : initiator
  end

end