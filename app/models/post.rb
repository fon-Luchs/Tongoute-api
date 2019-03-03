class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true

  belongs_to :wall

  validates :wall_id, :postable_type, :postable_id, :body, presence: true
end
