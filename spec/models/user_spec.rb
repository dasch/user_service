require 'rails_helper'

describe User do
  describe "#suspended?" do
    let(:user) { User.create!(name: "Jennifer", email: "jen@example.com") }

    it "returns true if there is an active suspension" do
      user.suspensions.create!
      expect(user.suspended?).to eq(true)
    end

    it "returns false if there are no suspensions" do
      expect(user.suspended?).to eq(false)
    end

    it "returns false if there are only inactive suspensions" do
      user.suspensions.create!(lifted_at: Time.now)
      expect(user.suspended?).to eq(false)
    end
  end
end
