# test/factories/rides.rb
FactoryBot.define do
  factory :ride do
    origin { "Location A" }
    destination { "Location B" }
    departure_time { 1.hour.from_now }
    available_seats { 4 }
    association :driver, factory: :user
    # Add other attributes as needed
  end
end
