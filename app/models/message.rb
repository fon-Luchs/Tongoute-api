class Message < ApplicationRecord
  belongs_to :messageable, polymorphic: true

  belongs_to :user

  validates :messageable_id, :messageable_type, :text, :user_id, presence: true
end
