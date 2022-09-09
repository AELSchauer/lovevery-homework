class User < ApplicationRecord
  has_many :children
  has_many :orders, through: :children

  validates :full_name, presence: true
  validates :email_address, presence: true
end
