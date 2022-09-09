class Gift < ApplicationRecord
    belongs_to :child
    belongs_to :order
    belongs_to :product
  
    validates :purchaser_name, presence: true
  end
  