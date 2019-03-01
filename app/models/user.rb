class User < ApplicationRecord
  has_secure_password

  has_one :auth_token, dependent: :destroy

  has_many :notes, dependent: :destroy

  has_many :posts

  has_many :relations, foreign_key: 'relating_id', class_name: 'Relation'

  has_many :blocking, through: :active_block, source: :blocked

  has_many :blockers, through: :pasive_block, source: :blocker

  has_many :active_conversations, foreign_key: :sender_id, class_name: 'Conversation'

  has_many :pasive_conversations, foreign_key: :recipient_id, class_name: 'Conversation'

  has_many :user_chats

  has_many :chats, through: :user_chats

  has_many :messages

  has_one  :wall, as: :wallable

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
