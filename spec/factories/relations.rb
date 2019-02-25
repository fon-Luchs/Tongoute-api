FactoryBot.define do
  factory :relation do
    related_id  { nil }

    relating_id { nil }

    state { 0 }
  end
end
