FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }

    last_name  { FFaker::Name.last_name }

    email      { FFaker::Internet.email }

    password   { FFaker::Internet.password }

    trait :with_auth_token do
      association :auth_token
    end

    trait :with_relation_content do
      after :create do |user|
        create_list :group, 2, user: user

        create_list :video, 4, user: user

        create_list :photos, 4, user: user

        create_list :audios, 4, user: user
      end
    end

    trait :with_information do
      number { FFaker::PhoneNumberDE.home_work_phone_number }

      address { FFaker::AddressPL.street }

      country { 'Poland' }

      locate { FFaker::AddressPL.city }

      about { FFaker::Skill.specialties }

      date { FFaker::Time.date }
    end
  end
end
