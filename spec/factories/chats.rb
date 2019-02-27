FactoryBot.define do
  factory :chat do
    name { FFaker::HipsterIpsum.word }

    creator_id { nil }
  end
end
