class FriendFinder

  def initialize(current_user = nil)
    @current_user = current_user
  end

  def find(subject)
    friend_resource subject
  end

  def all
    friend_collection
  end

  private

  def friend_collection
    collection = @current_user.subscribers.select{ |u| is_friend?(u) }
    collection =  User.where(id: collection.map(&:id))
  end

  def friend_resource(subject)
    if is_friend? set_user subject
      set_user subject
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def is_friend?(user)
    @current_user.subscribers.include?(user) and @current_user.subscribing.include?(user) == true
  end

  def set_user(subject)
    if subject.is_a? String
      User.find(subject)
    else
      subject
    end
  end
end
