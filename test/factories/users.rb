# test/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "test@example.com" }
    # Add other attributes as needed
  end
end
