class Relation < ApplicationRecord
  belongs_to :initiator, class_name: 'User', foreign_key: :relating_id

  belongs_to :initiated, class_name: 'User', foreign_key: :related_id

  enum state: { subscriber: 0, friend: 1, banned: 2 } 

  validates :related_id, uniqueness: { scope: :initiator}

  validate :disallow_self_referential_relation

  def disallow_self_referential_relation
    if related_id == relating_id
      errors.add(:related_id, 'cannot refer back to the author')
    end
  end
end
