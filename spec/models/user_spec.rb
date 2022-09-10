require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do
    it "requires full_name presence" do
      user = build(:user, full_name: nil)

      expect(user.valid?).to eq(false)
      expect(user.errors[:full_name].size).to eq(1)
    end

    it "requires email_address presence" do
      user = build(:user, email_address: nil)

      expect(user.valid?).to eq(false)
      expect(user.errors[:email_address].size).to eq(2)
    end

    it "validates email_address format" do
      user = build(:user, email_address: "not an email address")

      expect(user.valid?).to eq(false)
      expect(user.errors[:email_address].size).to eq(1)
    end
  end
end
