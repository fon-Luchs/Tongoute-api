FactoryBot.define do
  factory :user_group do
    user_id { user.id }
    group_id { group.id }
  end
end
