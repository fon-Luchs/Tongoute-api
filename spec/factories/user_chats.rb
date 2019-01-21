FactoryBot.define do
  factory :user_chat do
    role { nil }

    chat_id { chat.id }

    user_id { user.id }
  end
end
