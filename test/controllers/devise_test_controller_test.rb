# test/controllers/devise_test_controller_test.rb
require 'test_helper'

class DeviseTestControllerTest < ActionDispatch::IntegrationTest
  test "devise helpers work" do
    # Create a user dynamically
    user = User.create!(
      email: "test#{SecureRandom.hex(4)}@example.com",
      password: 'password123',
      password_confirmation: 'password123',
      name: 'Test User',
      phone: "+1#{rand(100..999)}#{rand(100..999)}#{rand(1000..9999)}",
      confirmed_at: Time.now
    )

    sign_in user

    # Use a route that definitely exists
    get root_path  # or rides_path, or any other existing route
    assert_response :success

    # Verify the user is signed in
    assert_equal user.id, controller.current_user.id
  end
end
