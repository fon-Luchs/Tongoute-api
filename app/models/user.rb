class User < ApplicationRecord
  has_secure_password

  has_one :auth_token, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :first_name, presence: true

  validates :last_name, presence: true
end
