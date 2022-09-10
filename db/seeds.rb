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

Order.find_or_create_by!(
  product_id: product.id,
  shipping_name: "Chris Smith",
  address: "123 Some Road",
  zipcode: "90210",
  user_facing_id: "890890908980980",
  paid: true,
  created_at: Date.today - 6.months,
  child: Child.find_or_create_by!(
    full_name: "Chris Smith",
    birthdate: Date.new(2019,1,4),
    created_at: Date.today - 6.months,
    user: User.find_or_create_by!(
      full_name: "Sammi Johnson",
      email_address: "sammi.johnson@email.com",
      created_at: Date.today - 6.months
    )
  ) 
)

Order.find_or_create_by!(
  product_id: product.id,
  shipping_name: "Chris Smith",
  address: "123 Different Avenue",
  zipcode: "90211",
  user_facing_id: "560560605650650",
  paid: true,
  child: Child.find_or_create_by!(
    full_name: "Chris Smith",
    birthdate: Date.new(2019,1,4),
    user: User.find_or_create_by!(
      full_name: "Sammi Johnson",
      email_address: "sammi.johnson@email.com",
    )
  ) 
)

Order.find_or_create_by!(
  product_id: product.id,
  shipping_name: "Jane Smith",
  address: "123 Some Road",
  zipcode: "90210",
  user_facing_id: "120120201210210",
  paid: true,
  child: Child.find_or_create_by!(
    full_name: "Jane Smith",
    birthdate: Date.new(2022,3,26),
    user: User.find_or_create_by!(
      full_name: "Sammi Johnson",
      email_address: "sammi.johnson@email.com",
    )
  )
)


Order.find_or_create_by!(
  product_id: product.id,
  shipping_name: "Mary Jones",
  address: "123 Any St",
  zipcode: "12345",
  user_facing_id: "340340403430430",
  paid: true,
  child: Child.find_or_create_by!(
    full_name: "Mary Jones",
    birthdate: Date.new(2022,3,26),
    user: User.find_or_create_by!(
      full_name: "John Jones",
      email_address: "john.jones@email.com",
    )
  )
)