FactoryBot.define do
  factory :chat do
    name { FFaker::HipsterIpsum.word }
  end
end
