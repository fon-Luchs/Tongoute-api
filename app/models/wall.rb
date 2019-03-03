class Wall < ApplicationRecord
  belongs_to :wallable, polymorphic: true

  has_many :posts

  validates :wallable_id, :wallable_type, presence: true
end
