class UserChat < ApplicationRecord
  belongs_to :chat

  belongs_to :user

  enum role: { user: 0, admin: 1, creator: 3 }

  validates :chat_id, presence: true

  validates :user_id, presence: true
end
