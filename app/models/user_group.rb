class UserGroup < ApplicationRecord
  belongs_to :group

  belongs_to :user

  validates :group, uniqueness: { scope: :user_id }

  validates :group, presence: true

  validates :user, presence: true
end
