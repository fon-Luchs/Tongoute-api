class Relation < ApplicationRecord
  belongs_to :initiator, class_name: 'User', foreign_key: :relating_id

  enum state: { subscriber: 0, friend: 1, banned: 2 }
end
