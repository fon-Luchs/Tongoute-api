class Subscriber < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: { scope: :subscriber_id }

  validate :chek_subscriber

  def chek_subscriber
    if self.user.id == self.subscriber_id
      self.errors[:base] << 'Invalid frendship request'
    end
  end
end
