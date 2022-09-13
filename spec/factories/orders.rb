FactoryBot.define do
  factory :order do
    shipping_name { Faker::Name.name }
    address { Faker::Address.street_address }
    zipcode { Faker::Address.zip_code }
    user_facing_id { SecureRandom.uuid[0..7] }
    paid { false }
    child { create(:child, full_name: shipping_name) }
    product { create(:product) }

    trait :in_past do
      child { create(:child, :in_past, full_name: shipping_name) }
      created_at { Date.today - 6.months }
      updated_at { Date.today - 6.months }
    end

    trait :paid do
      paid { true }
    end
  end
end
