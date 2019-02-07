class UserDecorator < Draper::Decorator
  delegate_all

  decorates_associations :notes

  def as_json(*args)
    if context[:show]
    {
      id: object.id,
      name: name,
      location: location,
      information: info,
      wall: wall,
      groups: groups,
      friends: relations.friends,
      subscribers: relations.subscribers,
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
      friends: relations.friends.decorate(context: {friend_index: true}).as_json,
      subscribers: relations.subscribers.decorate(context: {friend_index: true}).as_json,
      subscribings: relations.subscribings.decorate(context: {friend_index: true}).as_json,
      black_list: relations.blocked_users.decorate(context: {friend_index: true}).as_json,
      videos: videos,
      photos: photos,
      audios: audios,
      notes: notes,
      bookmark: bookmark
    }
    
    elsif context[:blocked]
    {
      id: object.id,
      name: name,
      status: 'This user add you in black list'
    }
    end
  end

  def relations
    RelationsTypeGetter.new(object)
  end

  def name
    [first_name, last_name].join(' ')
  end

  def info
    {
      email: object.email,
      number: object.number,
      bday: object.date,
      relation: [relation, relation],
      address: object.address,
      location: location,
      about_self: object.about
    }
  end

  def location
    [country, locate].join(', ')
  end

  def relation
    {
      id: 23,
      name: 'Jarry Smith',
      relations: 'Best friend'
    }
  end

  def wall
    posts = Post.all.where(destination_id: id)
    posts.decorate
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
