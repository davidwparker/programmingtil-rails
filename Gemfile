source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# https://github.com/cyu/rack-cors
gem 'rack-cors'

# Authentication
# https://github.com/heartcombo/devise
gem 'devise', github: 'heartcombo/devise'

# JWT devise for API
# https://github.com/waiting-for-dev/devise-jwt
gem 'devise-jwt'

# Authorization
# https://github.com/varvet/pundit
gem 'pundit'

# JSON API
# Previously known as FastJson API
# https://github.com/jsonapi-serializer/jsonapi-serializer
gem 'jsonapi-serializer'

# Friendly IDs
# https://github.com/norman/friendly_id
gem 'friendly_id', '~> 5.4.0'

# Perform background queue jobs
# https://github.com/mperham/sidekiq
gem 'sidekiq'

# Create our sitemap
# https://github.com/kjvarga/sitemap_generator
gem 'sitemap_generator'

# AWS for storage
# https://github.com/aws/aws-sdk-ruby
gem 'aws-sdk-s3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # RSpec for testing
  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails'
  # Needed for rspec
  gem 'rexml'
  gem 'spring-commands-rspec'
  # https://github.com/grosser/parallel_tests
  gem 'parallel_tests'

  # .env environment variable
  # https://github.com/bkeepers/dotenv
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Annotate models and more
  # https://github.com/ctran/annotate_models
  gem 'annotate'

  # Local Emails
  # https://github.com/ryanb/letter_opener
  gem 'letter_opener'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  # Code coverage
  # https://github.com/colszowka/simplecov
  gem 'simplecov', require: false

  # Clear out database between runs
  # https://github.com/DatabaseCleaner/database_cleaner
  gem 'database_cleaner-active_record'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
