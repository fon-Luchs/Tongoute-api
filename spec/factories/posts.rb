FactoryBot.define do
  factory :post do
    destination_id { user.id }
    title { FFaker::LoremUA.sentence }
    body { FFaker::LoremUA.paragraph }
  end
end
