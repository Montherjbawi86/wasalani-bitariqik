source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.0"
# Remove bundler from Gemfile - let it be managed automatically
# gem "bundler", "~> 2.7.1"

# Use the Puma web server
gem 'puma', '~> 6.0'  # Changed to ~> 6.0 for better version control

# Use JavaScript with ESM import maps
gem "importmap-rails"
gem "sprockets-rails"
gem "dartsass-rails"
gem 'bcrypt', '~> 3.1.7'

# Hotwire's SPA-like page accelerator
gem "turbo-rails"
group :development, :test do
  gem 'factory_bot_rails'
end
# Authentication and UI
gem 'devise'
gem 'bootstrap', '~> 5.1'
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'kaminari' # للترقيم
gem 'rails-i18n' # للدعم العربي
gem 'database_cleaner-active_record'
# Gemfile
group :test do
  gem 'database_cleaner-active_record'
end
# Hotwire's modest JavaScript framework
gem "stimulus-rails"

# Build JSON APIs with ease
gem "jbuilder"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Database gems - PROPERLY GROUPED
group :development, :test do
  gem 'sqlite3', '~> 2.7'
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows]
end

group :production, :test do
  gem 'pg', '~> 1.1'
end

group :development do
  # Use console on exceptions pages
  gem "web-console"
end
