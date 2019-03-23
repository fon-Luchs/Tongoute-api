FactoryBot.define do
  factory :conversation do
    senderable_id      { senderable.id }

    senderable_type    { senderable.class.name }

    recipientable_id   { recipientable.id }

    recipientable_type { recipientable.class.name }
  end
end
