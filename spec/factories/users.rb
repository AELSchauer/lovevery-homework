FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email_address { Faker::Internet.email(name: full_name) }

    trait :in_past do
      created_at { Date.today - 6.months }
      updated_at { Date.today - 6.months }
    end
  end
end
