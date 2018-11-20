class FriendFinder
  def initialize(current_user = nil)
    @current_user = current_user
  end

  def find(user)
    user if @current_user.subscribers.include?(user) == @current_user.subscribing.include?(user)
  end

  def all
    collection = @current_user.subscribers.select{ |u| @current_user.subscribers.include?(u) == @current_user.subscribing.include?(u) }
    collection =  User.where(id: collection.map(&:id))
  end
end