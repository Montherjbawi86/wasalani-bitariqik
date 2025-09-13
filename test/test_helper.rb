# test/test_helper.rb
# At the top of test/test_helper.rb
I18n.default_locale = :en
I18n.locale = :en
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'database_cleaner-active_record'
require 'bcrypt'

# Configure DatabaseCleaner
DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)
class ActiveSupport::TestCase
  # Clear database before each test
  setup do
    User.delete_all
  end
end
class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml
  fixtures :all

  # Include FactoryBot if you're using it
  include FactoryBot::Syntax::Methods if defined?(FactoryBot)

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end

  # REMOVE the manual destroy_all calls - DatabaseCleaner handles this!
  # setup do
  #   Booking.destroy_all
  #   Ride.destroy_all
  #   User.destroy_all
  # end
end
