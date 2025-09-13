# test/factories/bookings.rb
FactoryBot.define do
  factory :booking do
    seats { 2 }
    association :user
    association :ride
    # Add other attributes as needed
  end
end
