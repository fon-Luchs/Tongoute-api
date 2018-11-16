class Relationship < ApplicationRecord
  belongs_to :subscriber, class_name: 'User'

  belongs_to :subscribed, class_name: 'User'

  validates :subscribed_id, presence: true
  
  validates :subscriber_id, presence: true
end
