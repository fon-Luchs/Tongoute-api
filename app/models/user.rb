class User < ApplicationRecord
  has_secure_password

  has_one :auth_token, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :number,
            format: {
              with: /\A^(?:\+?\d{1,3}[- ]?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{2}[- ]?\d{2}$\z/
            }, allow_nil: true

  validates :about, length: { minimum: 5 }, allow_nil: true

  validates :address, length: { in: 5..35 }, allow_nil: true

  validates :country, length: { in: 2..35 }, allow_nil: true

  validates :locate, length: { in: 2..35 }, allow_nil: true

  validates_date :date, allow_nil: true
end
