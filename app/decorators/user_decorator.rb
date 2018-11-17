class UserDecorator < Draper::Decorator
  delegate_all

  decorates_associations :notes
  decorates_associations :block_users
  decorates_associations :subscribers

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
  {
    id: 33,
    name: 'Jarry Smith',
    relations: 'Friend'
  }
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
