FactoryBot.define do
  factory :user do
    name = Faker::Name.name

    full_name { name }
    email_address { Faker::Internet.email(name: name) }
  end
end
