# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# COMMANDS and things

## EPISODE 1:
```
rails new programmingtil-rails-1 --api --database=postgresql
```

## EPISODE 2:

  database.yml > host: 127.0.0.1 -> (needed because WSL)

Gemfile
```ruby
gem 'devise', github: 'heartcombo/devise'
gem 'devise-jwt'
gem 'rack-cors'
```

```
rake db:create
```

```
rails generate devise:install
rails generate devise user
rails db:migrate
```

devise.rb
```ruby
  config.jwt do |jwt|
    jwt.secret = ENV['DEVISE_JWT_SECRET_KEY']
    jwt.dispatch_requests = [
      ['POST', %r{^/signin$}],
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/signout$}]
    ]
    jwt.expiration_time = 14.days.to_i
    # Use default aud_header
    jwt.aud_header = 'JWT_AUD'
  end
```
