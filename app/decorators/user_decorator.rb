class UserDecorator < Draper::Decorator
  delegate_all

  decorates_associations :notes
  decorates_associations :subscribers
  decorates_associations :friends

  def as_json(*args)
    params.select { |key, value| @context.key? key }
  end

  def params
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
      notes: notes,
      bookmark: bookmark
    }
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
