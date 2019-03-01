FactoryBot.define do
  factory :wall do
    wallable_type { wallable.class.name }
    wallable_id { wallable.id }
  end
end
