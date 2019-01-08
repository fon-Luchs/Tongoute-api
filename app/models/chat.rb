class Chat < ApplicationRecord
  has_many :user_chats

  has_many :users, through: :user_chats

  validates :name, presence: true

  validates :creator_id, presence: true
end
