class Group < ApplicationRecord
  has_one  :wall, as: :wallable

  has_many :user_groups

  has_many :users, through: :user_groups

  has_many :posts, as: :postable

  validates :name, presence: true

  validates :creator_id, presence: true
end
