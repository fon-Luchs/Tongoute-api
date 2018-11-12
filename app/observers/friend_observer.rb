class FriendObserver < ActiveRecord::Observer
  def after_create(friend)
    create_friendship friend
  end

  def before_destroy(friend)
    @friendship = friend
  end

  def after_destroy
    destroy_friendsip @friendship
  end

  private

  def create_friendship(friend)
    @user = User.find(friend.friend_id)
    add_to_subs(@user, friend)
    @friendship = @user.friends.new(friend_id: friend.user.id)
    if @friendship.save
      del_from_subs(friend.user, @user)
      del_from_subs(@user, friend.user)
    end
  end

  def destroy_friendsip(friend)
    add_to_subs()
  end

  def add_to_subs(user, sub_user)
    subscriber = user.subscribers.new(subscriber_id: sub_user.user.id)
    subscriber.save
  end

  def del_from_subs(user, sub_user)
    subscribe = user.subscribers.find_by(subscriber_id: sub_user.id)
    subscribe.destroy
  end
end