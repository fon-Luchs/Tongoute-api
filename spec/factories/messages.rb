FactoryBot.define do
  factory :message do
    user_id { nil }
    messageable_id { nil }
    messageable_type { nil }
    text { FFaker::LoremPL.paragraph }
  end
end
