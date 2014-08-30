require 'rails_helper'

describe "Suspensions API" do
  example "suspending a user" do
    user1 = User.create!(name: "Alfred", email: "alfred@example.com")
    user2 = User.create!(name: "Jennifer", email: "jen@example.com")

    post "/suspensions", users: [user1.id, user2.id]

    expect(response.status).to eq(204)

    expect(user1).to be_suspended
    expect(user2).to be_suspended
  end
end
