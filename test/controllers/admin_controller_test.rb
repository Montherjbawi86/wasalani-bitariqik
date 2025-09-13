# test/controllers/admin_controller_test.rb
require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: "admin#{SecureRandom.hex(4)}@example.com",
      password: 'password123',
      password_confirmation: 'password123',
      name: 'Admin User',
      phone: "+1#{rand(100..999)}#{rand(100..999)}#{rand(1000..9999)}",
      confirmed_at: Time.now,
      role: 'admin'
    )

    sign_in @user
  end

  test "should get users" do
    get admin_users_path
    assert_response :success
  end
end
