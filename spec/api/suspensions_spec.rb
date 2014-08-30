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

  example "publishing a message when a user is suspended" do
    $bunny.with_channel do |channel|
      queue = channel.queue("", auto_delete: true)
      queue.bind(channel.fanout("users.suspensions"))

      user = User.create!(name: "Alfred", email: "alfred@example.com")

      post "/suspensions", users: [user.id]

      delivery_info, properties, payload = queue.pop
      message = JSON.parse(payload).with_indifferent_access

      expect(message[:id]).to eq(user.id)
      expect(message[:name]).to eq("Alfred")
      expect(message[:email]).to eq("alfred@example.com")
    end
  end
end
