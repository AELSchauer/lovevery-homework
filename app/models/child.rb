class Child < ApplicationRecord
  belongs_to :user
  has_many :orders

  def latest_shipping_details
    orders.order(created_at: :desc).first
  end
end
