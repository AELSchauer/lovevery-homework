FactoryBot.define do
  factory :product do
    name { Faker::Lorem.words(number: 3).map(&:capitalize).join(" ") }
    description { Faker::Lorem.sentence }
    price_cents { rand(500..10000) }
    age_low_weeks { rand(0..52) }
    age_high_weeks { age_low_weeks + rand(12..104) }
  end
end
