class BlockUser < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: { scope: :blocked_id }

  validate :chek_subscriber

  def chek_subscriber
    if self.user.id == self.blocked_id
      self.errors[:base] << 'Invalid black list request'
    end
  end
end
