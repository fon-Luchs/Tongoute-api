FactoryBot.define do
  factory :block_user do
    association :user, factory: :user
    blocked_id { 1 }
  end
end
