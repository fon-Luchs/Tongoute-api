class Conversation < ApplicationRecord
  has_many :messages, as: :messageable
  
  belongs_to :senderable, polymorphic: true

  belongs_to :recipientable, polymorphic: true

  validates :senderable_id, presence: true

  validates :recipientable_id, presence: true

  validates :senderable_type, presence: true

  validates :recipientable_type, presence: true

  validates :senderable_id, uniqueness: { scope: [:recipientable_id, :recipientable_type, :senderable_type] }
end
