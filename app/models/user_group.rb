class UserGroup < ApplicationRecord
  belongs_to :group

  belongs_to :user

  validates :group, uniqueness: { scope: :user_id }
end
