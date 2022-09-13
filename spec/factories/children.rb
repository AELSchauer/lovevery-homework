FactoryBot.define do
  factory :child do
    full_name { Faker::Name.name }
    birthdate { Date.today - (rand((-30 * 7)..(4 * 365))).days }
    user { create(:user) }

    trait :in_past do
      user { create(:user, :in_past) }
      created_at { Date.today - 6.months }
      updated_at { Date.today - 6.months }
    end
  end
end
