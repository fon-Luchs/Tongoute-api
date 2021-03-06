class UserChat < ApplicationRecord
  belongs_to :chat

  belongs_to :user

  enum role: { user: 0, admin: 1, creator: 2 }

  validates :chat, uniqueness: { scope: :user_id }
end
