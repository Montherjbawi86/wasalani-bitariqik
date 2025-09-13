# test/controllers/home_controller_test.rb
require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url  # Use root_url for home#index
    assert_response :success
  end

  test "should get about" do
    get about_url  # Use the custom named route
    assert_response :success
  end

  test "should get contact" do
    get contact_url  # Use the custom named route
    assert_response :success
  end

  # Remove this extra 'end' - it should only be at the end of the class
end
