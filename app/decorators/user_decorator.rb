class UserDecorator < Draper::Decorator
  delegate_all

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
    {
      id: 3,
      title: 'Hello in my wall',
      body: nil,
      likes: 42
    }
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

  def friends
    [
      {
        id: 32,
        name: 'Maria Viskes'
      },

      {
        id: 2,
        name: 'Nikolay Miromanov'
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

  def notes
    {
      id: 3,
      title: 'Hello in my wall',
      body: nil
    }
  end

  def bookmark
    {

    }
  end
end
