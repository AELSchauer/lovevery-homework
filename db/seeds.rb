# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
product = Product.find_or_create_by!(
  name: "The Looker Play Kit",
  description: "Includes a silicone rattle with removable ball, standing card holder, and simple black and white card set",
  price_cents: 3600,
  age_low_weeks: 0,
  age_high_weeks: 12,
)
Product.find_or_create_by!(
  name: "The Charmer Play Kit",
  description: "Includes a wooden rattle, rolling bell, soft book, and mirror card",
  price_cents: 4000,
  age_low_weeks: 13,
  age_high_weeks: 17
)
Product.find_or_create_by!(
  name: "The Senser Play Kit",
  description: "Includes a magic tissue box, magic tissues, montessori ball, and play socks",
  price_cents: 3200,
  age_low_weeks: 21,
  age_high_weeks: 26
)

user_1 = User.find_or_create_by!(
  full_name: "Sammi Johnson",
  email_address: "sammi.johnson@email.com",
)

child_1 = Child.find_or_create_by!(
  full_name: "Chris Smith",
  birthdate: Date.new(2019,1,4),
  user: user_1
)

Child.find_or_create_by!(
  full_name: "Jane Smith",
  birthdate: Date.new(2022,3,26),
  user: user_1
)

Order.find_or_create_by!(
  product_id: product.id,
  shipping_name: "Chris Smith",
  address: "123 Some Road",
  zipcode: "90210",
  user_facing_id: "890890908980980",
  paid: true,
  child: child_1 
)

user_2 = User.find_or_create_by!(
  full_name: "Jane Doe",
  email_address: "jane.doe@email.com",
)

Child.find_or_create_by!(
  full_name: "John Doe",
  birthdate: Date.new(2018,12,12),
  user: user_2
)