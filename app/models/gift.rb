class Gift < ApplicationRecord
    belongs_to :child
    belongs_to :order
    has_one :product, through: :order
  
    validates :purchaser_name, presence: true
  end
  