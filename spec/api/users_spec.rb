require 'rails_helper'

describe "Users API" do
  example "creating a new user" do
    post "/users", name: "John Doe", email: "john@example.com"

    expect(response.status).to eq(201)

    json = JSON.parse(response.body).with_indifferent_access

    expect(json[:name]).to eq("John Doe")
    expect(json[:email]).to eq("john@example.com")
  end
end
