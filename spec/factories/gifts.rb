FactoryBot.define do
  factory :gift do
    name = Faker::Name.name

    purchaser_name { name }
    purchaser_email { Faker::Internet.email(name: name) }
  end
end
