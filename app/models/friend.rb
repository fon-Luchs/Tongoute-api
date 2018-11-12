class Friend < ApplicationRecord
  belongs_to :user

  validate :check_friendship

  def check_friendship
    unless Subscriber.exists?(user_id: user.id, subscriber_id: friend_id)
      self.errors[:base] << 'Invalid friend response'
    end
  end
end
