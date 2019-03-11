FactoryBot.define do
  factory :group do
    creator_id { nil }
    name { FFaker::HipsterIpsum.word }
    info { FFaker::CheesyLingo.sentence }
  end

  trait :with_wall do
    after :create do |group|
      create :wall, wallable: group
    end
  end
end
