class Group < ApplicationRecord
  has_one  :wall, as: :wallable

  has_many :user_groups

  has_many :users, through: :user_groups

  has_many :posts, as: :postable

  has_many :active_conversations, as: :senderable, class_name: 'Conversation'

  has_many :pasive_conversations, as: :recipientable, class_name: 'Conversation'

  has_many :messages, as: :messageable

  validates :name, presence: true

  validates :creator_id, presence: true
end
