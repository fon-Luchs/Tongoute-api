class Chat < ApplicationRecord
  has_many :user_chats

  has_many :users, through: :user_chats

  has_many :messages, as: :messageable

  validates :name, presence: true

  validates :creator_id, presence: true
end
