# test/controllers/users_controller_test.rb
require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # Remove the include line for now and test manually

  setup do
    @user = User.create!(
      name: "Test User",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password",
      phone: "123-456-7890"
    )
  end

  test "manual sign in test" do
    # Manual sign in by posting to devise session path
    post user_session_path, params: {
      user: {
        email: @user.email,
        password: 'password'
      }
    }

    # Check if sign in was successful (should redirect)
    assert_response :redirect
    assert_redirected_to root_path

    # Follow the redirect
    follow_redirect!
    assert_response :success

    # Check if we have a user in the session
    assert session['warden.user.user.key'].present?, "User should be in session"
  end
end
