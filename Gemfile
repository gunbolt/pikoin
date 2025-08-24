source "https://rubygems.org"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
# Rails authentication with email & password [https://github.com/thoughtbot/clearance]
gem "clearance"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"
# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false
# Add types to class initializers [https://github.com/yippee-fun/literal]
gem "literal"
# Dealing with money and currency conversion [https://github.com/RubyMoney/money]
gem "money"
# Pagination Ruby Gem [https://github.com/ddnexus/pagy]
gem "pagy"
# General icons extension for Phlex [https://github.com/AliOsm/phlex-icons]
gem "phlex-icons-lucide"
# An object-oriented alternative to ActionView for Ruby on Rails [https://github.com/phlex-ruby/phlex-rails]
gem "phlex-rails"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma"
# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails"
# Rails related I18n stuff [https://github.com/svenfuchs/rails-i18n]
gem "rails-i18n"
# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
# Use sqlite3 as the database for Active Record
gem "sqlite3"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  # A library for setting up Ruby objects as test data [https://github.com/thoughtbot/factory_bot_rails]
  gem "factory_bot_rails"
end

group :development do
  # Ruby's bikeshed-proof linter and formatter [https://github.com/standardrb/standard]
  gem "standard"
  gem "standard-rails"
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  # Selenium helps to automate popular browsers. https://github.com/SeleniumHQ/selenium/tree/trunk/rb
  gem "selenium-webdriver"
  # Simple one-liner tests for common Rails functionality [https://github.com/thoughtbot/shoulda]
  gem "shoulda-matchers"
end
