class UserDecorator < Draper::Decorator
  delegate_all

  decorates_associations :notes
  decorates_associations :block_users
  decorates_associations :subscribers
  decorates_associations :subscribing

  def as_json(*args)
    if context[:show]
    {
      id: object.id,
      name: name,
      location: location,
      information: info,
      wall: wall,
      groups: groups,
      friends: friends,
      subscribers: subscribers,
      videos: videos,
      photos: photos,
      audios: audios,
    }

    elsif context[:index]
    {
      id: object.id,
      name: name,
      location: location
    }
    
    elsif context[:profile]
    {
      id: object.id,
      name: name,
      location: location,
      information: info,
      wall: wall,
      groups: groups,
      friends: friends,
      subscribers: subscribers,
      subscribing: subscribing,
      black_list: block_users,
      videos: videos,
      photos: photos,
      audios: audios,
      notes: notes,
      bookmark: bookmark
    }
    
    elsif context[:banned]
    {
      id: object.id,
      name: name,
      status: 'This user add you in black list'
    }

    elsif context[:subscriber_show]
    {
      id: object.id,
      name: name,
      status: 'Subscriber',
      information: info,
      wall: wall,
      groups: groups.count,
      friends: friends.count,
      subscribers: subscribers.count,
      videos: videos.count,
      photos: photos.count,
      audios: audios.count
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
      name: name,
      status: 'Subscribed',
      information: info,
      wall: wall,
      groups: groups.count,
      friends: friends.count,
      subscribers: subscribers.count,
      videos: videos.count,
      photos: photos.count,
      audios: audios.count
    }

    elsif context[:subscribed_index]
    {
      id: object.id,
      name: name,
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

  def name
    [first_name, last_name].join(' ')
  end

  def info
    {
      email: object.email,
      number: object.number,
      bday: object.date,
      relation: [relations, relations],
      address: object.address,
      location: location,
      about_self: object.about
    }
  end

  def location
    [country, locate].join(', ')
  end

  def friends
    friends = FriendFinder.new(self).all
    if friends.empty?
      []
    else
      friends.decorate(context: {friend_index: true}).as_json
    end
  end

  def relations
    {
      id: 23,
      name: 'Jarry Smith',
      relations: 'Best friend'
    }
  end

  def wall
    posts = Post.all.where(destination_id: id)
    posts.decorate.as_json
  end

  def groups
    [
      {
        id: 1,
        name: 'Tongoute Community',
        users: 133_221
      },

      {
        id: 1332,
        name: 'Slayer',
        users: 321_42
      }
    ]
  end

  def videos
    [
      {
        id: 1,
        name: '4231.mp4',
        descriptions: 'Я і Толік'
      }
    ]
  end

  def photos
    [
      {
        id: 12,
        name: '4231.jpg',
        descriptions: 'Я і Толік'
      }
    ]
  end

  def audios
    [
      {
        id: 21,
        name: 'дорожка13.mp3'
      }
    ]
  end

  def bookmark
    {

    }
  end
end
