# test/controllers/rides/bookings_controller_test.rb
require 'test_helper'

module Rides
  class BookingsControllerTest < ActionDispatch::IntegrationTest
    setup do
      # Create a passenger user (different from driver)
      @passenger = User.create!(
        email: "passenger#{SecureRandom.hex(4)}@example.com",
        password: 'password123',
        password_confirmation: 'password123',
        name: 'Passenger User',
        phone: "+1#{rand(100..999)}#{rand(100..999)}#{rand(1000..9999)}",
        confirmed_at: Time.now,
        role: 0 # passenger role (0)
      )

      # Create a driver user
      @driver = User.create!(
        email: "driver#{SecureRandom.hex(4)}@example.com",
        password: 'password123',
        password_confirmation: 'password123',
        name: 'Driver User',
        phone: "+1#{rand(100..999)}#{rand(100..999)}#{rand(1000..9999)}",
        confirmed_at: Time.now,
        role: 1 # driver role (1)
      )

      sign_in @passenger

      # Create a ride with ALL required fields based on validations
      @ride = Ride.create!(
        driver: @driver,
        origin: 'City A',                    # Required
        destination: 'City B',               # Required
        from_city: 'City A',                 # Optional but exists in schema
        to_city: 'City B',                   # Optional but exists in schema
        departure_time: DateTime.now + 1.hour, # Required
        available_seats: 4,                  # Required, > 0
        price: 20.0                          # Required, >= 0
      )
    end

    test "should create booking" do
      assert_difference('Booking.count') do
        post ride_bookings_url(@ride), params: {
          booking: {
            seats: 1
          }
        }
      end

      assert_redirected_to ride_path(@ride)
    end
  end
end
