class Child < ApplicationRecord
  belongs_to :user
  has_many :orders

  def latest_order
    orders.sort(created_at: :desc)
  end
end
