# test/controllers/rides_controller_test.rb
require "test_helper"

class RidesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create!(
      name: "Test User",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password",
      phone: "123-456-7890"
    )
    sign_in @user
  end

  test "should create ride" do
    assert_difference('Ride.count') do
      post rides_url, params: {
        ride: {
          origin: "Location A",
          destination: "Location B",
          from_city: "City A",
          to_city: "City B",
          departure_time: 1.hour.from_now,
          available_seats: 4,
          price: 25.00,
          driver_id: @user.id  # Add driver_id to params
        }
      }
    end
    assert_redirected_to ride_path(Ride.last)
  end
end
