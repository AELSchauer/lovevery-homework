FactoryBot.define do
  factory :gift do
    purchaser_name { Faker::Name.name }
    purchaser_email { Faker::Internet.email(name: purchaser_name) }
    child { child }
    order { create(:order, child: child) }
  end
end
