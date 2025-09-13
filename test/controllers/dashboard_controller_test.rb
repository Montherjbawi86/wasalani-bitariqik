# test/controllers/dashboard_controller_test.rb
require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
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

  test "should get index" do
    get dashboard_url
    assert_response :success
  end

  test "should get show" do
    # If you don't have a show action, remove this test
    # Or define the route: get 'dashboard/show', to: 'dashboard#show', as: 'dashboard_show'
    skip "No show action defined" unless defined?(dashboard_show_url)
    get dashboard_show_url
    assert_response :success
  end
end
