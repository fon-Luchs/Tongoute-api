FactoryBot.define do
  factory :post do
    body { FFaker::LoremUA.paragraph }
    wall_id { wall.id }
    postable_id { postable.id }
    postable_type { postable.class.name }
    pinned { false }
  end
end
