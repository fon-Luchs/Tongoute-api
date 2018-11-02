FactoryBot.define do
  factory :note do
    title { FFaker::LoremUA.sentence }
    body { FFaker::LoremUA.paragraph }
  end
end
