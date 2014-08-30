require 'rails_helper'

describe "Users API" do
  example "creating a new user" do
    post "/users", name: "John Doe", email: "john@example.com"

    expect(response.status).to eq(201)

    json = JSON.parse(response.body).with_indifferent_access

    expect(json[:name]).to eq("John Doe")
    expect(json[:email]).to eq("john@example.com")
  end

  example "publishing a message when a new user is created" do
    $bunny.with_channel do |channel|
      queue = channel.queue("", auto_delete: true)
      queue.bind(channel.fanout("users.signups"))

      post "/users", name: "John Doe", email: "john@example.com"

      delivery_info, properties, payload = queue.pop
      message = JSON.parse(payload).with_indifferent_access

      expect(message[:name]).to eq("John Doe")
      expect(message[:email]).to eq("john@example.com")
    end
  end
end
