FactoryBot.define do
  factory :child do
    name = Faker::Name.name

    full_name { name }
    birthdate { Date.today - (rand((-30 * 7)..(4 * 365))).days }
    user { create(:user) }
  end
end
