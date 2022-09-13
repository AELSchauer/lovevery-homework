require 'rails_helper'

RSpec.feature "Gift Product", type: :feature do
  scenario "Creates an order and charges us" do
    product = create(:product, price_cents: 1000)
    old_order = create(:order, :in_past)
    
    visit "/products/1"
    
    click_on "Gift Now $10.00"
    
    fill_in "gift[credit_card_number]", with: "4111111111111111"
    fill_in "gift[expiration_month]", with: 12
    fill_in "gift[expiration_year]", with: 25
    fill_in "gift[purchaser_name]", with: "Pat Jones"
    fill_in "gift[purchaser_email]", with: "pat.jones@email.com"
    fill_in "child[full_name]", with: old_order.child.full_name
    fill_in "child[birthdate]", with: old_order.child.birthdate
    fill_in "user[full_name]", with: old_order.child.user.full_name
    
    click_on "Purchase"
    
    expect(page).to have_content("Thanks for Your Order")
    expect(page).to have_content(Order.last.user_facing_id)
    expect(page).to have_content(old_order.child.full_name)
  end
  
  scenario "Tells us when there was a problem charging our card" do
    product = create(:product, price_cents: 1000)
    old_order = create(:order, :in_past)
    
    visit "/products/1"
    
    click_on "Gift Now $10.00"
    
    fill_in "gift[credit_card_number]", with: "4242424242424242"
    fill_in "gift[expiration_month]", with: 12
    fill_in "gift[expiration_year]", with: 25
    fill_in "gift[purchaser_name]", with: "Pat Jones"
    fill_in "gift[purchaser_email]", with: "pat.jones@email.com"
    fill_in "child[full_name]", with: old_order.child.full_name
    fill_in "child[birthdate]", with: old_order.child.birthdate
    fill_in "user[full_name]", with: old_order.child.user.full_name
    
    click_on "Purchase"
    
    expect(page).not_to have_content("Thanks for Your Order")
    expect(page).to have_content("Problem with your order")
    expect(page).to have_content(Order.last.user_facing_id)
    expect(page).to have_content(old_order.child.full_name)
  end
  
  scenario "Shows us the gift message if included" do
    product = create(:product, price_cents: 1000)
    old_order = create(:order, :in_past)
    
    visit "/products/1"
    
    click_on "Gift Now $10.00"
    
    fill_in "gift[credit_card_number]", with: "4111111111111111"
    fill_in "gift[expiration_month]", with: 12
    fill_in "gift[expiration_year]", with: 25
    fill_in "gift[purchaser_name]", with: "Pat Jones"
    fill_in "gift[purchaser_email]", with: "pat.jones@email.com"
    fill_in "gift[gift_message]", with: "Happy Birthday! -Love, Grandma"
    fill_in "child[full_name]", with: old_order.child.full_name
    fill_in "child[birthdate]", with: old_order.child.birthdate
    fill_in "user[full_name]", with: old_order.child.user.full_name
    
    click_on "Purchase"
    
    expect(page).to have_content("Thanks for Your Order")
    expect(page).to have_content("Happy Birthday! -Love, Grandma")
  end
  
  scenario "Shows us a placeholder message if gift message not included" do
    product = create(:product, price_cents: 1000)
    old_order = create(:order, :in_past)
    
    visit "/products/1"
    
    click_on "Gift Now $10.00"
    
    fill_in "gift[credit_card_number]", with: "4111111111111111"
    fill_in "gift[expiration_month]", with: 12
    fill_in "gift[expiration_year]", with: 25
    fill_in "gift[purchaser_name]", with: "Pat Jones"
    fill_in "gift[purchaser_email]", with: "pat.jones@email.com"
    fill_in "child[full_name]", with: old_order.child.full_name
    fill_in "child[birthdate]", with: old_order.child.birthdate
    fill_in "user[full_name]", with: old_order.child.user.full_name
    
    click_on "Purchase"
    
    expect(page).to have_content("Thanks for Your Order")
    expect(page).to have_content("No gift message provided")
  end
  
  scenario "Child data couldn't be found" do
    product = create(:product, price_cents: 1000)
    old_order = create(:order, :in_past)
    
    visit "/products/1"
    
    click_on "Gift Now $10.00"
    
    fill_in "gift[credit_card_number]", with: "4111111111111111"
    fill_in "gift[expiration_month]", with: 12
    fill_in "gift[expiration_year]", with: 25
    fill_in "gift[purchaser_name]", with: "Pat Jones"
    fill_in "gift[purchaser_email]", with: "pat.jones@email.com"
    fill_in "child[full_name]", with: "Jason Binks"
    fill_in "child[birthdate]", with: "2022-01-01"
    fill_in "user[full_name]", with: "Mary Binks"
    
    click_on "Purchase"
    
    expect(page).not_to have_current_path("/orders/#{Order.last.id}")
    expect(page).to have_content("Unable to locate child shipping based on information provided")
  end
end
