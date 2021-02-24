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

## EPISODE 3

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

user.rb
```ruby
  devise :database_authenticatable,
    :confirmable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :jwt_authenticatable,
    jwt_revocation_strategy: self
```

```bash
rails g migration createAllowlistedJwts
```

create_allowlisted_jwts.rb
```ruby
  def change
    create_table :allowlisted_jwts do |t|
      t.references :users, foreign_key: { on_delete: :cascade }, null: false
      t.string :jti, null: false
      t.string :aud, null: false
      t.datetime :exp, null: false
      t.string :remote_ip
      t.string :os_data
      t.string :browser_data
      t.string :device_data
      t.timestamps null: false
    end

    add_index :allowlisted_jwts, :jti, unique: true
  end
```

models/allowlisted_jwt.rb
```ruby
class AllowlistedJwt < ApplicationRecord
end
```

```
rake db:migrate
```
