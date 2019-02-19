class RelationsTypeGetter

  attr_reader :user

  def initialize(user=nil)
    @user = user
  end

  def subscribers
    subscribers_collection
  end

  def subscribings
    subscribings_collection
  end

  def friends
    friends_collection
  end

  def blocked_users
    banneds_collection
  end

  private

  def subscribers_collection
    Relation.subscriber.where(related_id: user.id)
  end

  def subscribings_collection
    Relation.subscriber.where(relating_id: user.id)
  end

  def friends_collection
    Relation.friend.where("related_id = ? or relating_id = ?", user.id, user.id)
  end

  def banneds_collection
    Relation.banned.where(relating_id: user.id)
  end
end
