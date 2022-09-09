require 'rails_helper'

RSpec.describe Gift, type: :model do
  describe "#validations" do
    it "requires purchaser_name presence" do
      gift = build(:gift, purchaser_name: nil)

      expect(gift.valid?).to eq(false)
      expect(gift.errors[:purchaser_name].size).to eq(1)
    end
  end
end
