# COMMANDS and things

```
redis-server
rails s
bundle exec sidekiq -c 1 -q default -q mailers
```

## EPISODE 26 - adding a contact us form and testing activejob

```
new file:   app/controllers/api/v1/contact_us_controller.rb
new file:   app/mailers/emails/contact_us_mailer.rb
new file:   app/models/concerns/contact_uses/hooks.rb
new file:   app/models/concerns/contact_uses/validations.rb
new file:   app/models/contact_us.rb
modified:   app/models/user.rb
new file:   app/views/emails/contact_us_mailer/contact.html.erb
modified:   config/environments/test.rb
modified:   config/locales/en.yml
modified:   config/routes.rb
new file:   db/migrate/20210602204347_create_contact_us.rb
modified:   db/schema.rb
new file:   spec/models/contact_us_spec.rb
modified:   spec/requests/comments_request_spec.rb
new file:   spec/requests/contact_us_request_spec.rb
modified:   spec/support/object_creators.rb
```

## EPISODE 25 - putting sitemap on AWS S3

TODO:
```
Ensure credentials are set in Rails credentials
Create new buckets on AWS S3
```

```
modified:   Gemfile
modified:   Gemfile.lock
modified:   README.md
modified:   config/credentials.yml.enc
modified:   config/sitemap.rb
```

## EPISODE 24 - Credentials

Resources:
* https://edgeguides.rubyonrails.org/security.html#custom-credentials
* https://s3.console.aws.amazon.com/
* https://blog.saeloun.com/2019/10/10/rails-6-adds-support-for-multi-environment-credentials.html

Commands
```
rails credentials:help
rails credentials:edit
rails credentials:edit --environment production
EDITOR=nano rails credentials:edit
cat config/credentials/production.key
heroku config:set RAILS_MASTER_KEY=`cat config/master.key`
```

Setup
```
Create user in IAM
Create bucket in S3
```

Usage
```
Rails.application.credentials.config
Rails.application.credentials.aws[:access_key_id]
```

## EPISODE 23 - Sitemap

Resources:
* https://github.com/kjvarga/sitemap_generator

```
bundle install
```

```
rake sitemap:install
rake sitemap:refresh
rake sitemap:refresh:no_ping
```

```
modified:   Gemfile
modified:   Gemfile.lock
modified:   README.md
modified:   app/controllers/posts_controller.rb
new file:   app/models/concerns/posts/scopes.rb
modified:   app/models/post.rb
new file:   config/sitemap.rb
new file:   public/sitemap.xml
```

## EPISODE 22 - Redis + Sidekiq

Resources:
* https://github.com/mperham/sidekiq

```
# Perform background queue jobs
# https://github.com/mperham/sidekiq
gem 'sidekiq'
```

```
bundle install
```

```
modified:   Gemfile
modified:   Gemfile.lock
modified:   Procfile
modified:   README.md
modified:   app/controllers/api/v1/posts_controller.rb
modified:   app/controllers/sessions_controller.rb
modified:   app/models/user.rb
modified:   app/serializers/post_show_serializer.rb
modified:   config/application.rb
config/initializers/redis.rb
config/initializers/sidekiq.rb
```

## EPISODE 21 - comments CRUD, and returning some with initial Post Show

```
modified:   README.md
modified:   app/controllers/api/v1/comments_controller.rb
modified:   app/models/concerns/abilities/commentable.rb
modified:   app/models/concerns/comments/logic.rb
modified:   app/models/concerns/posts/hooks.rb
modified:   app/models/post.rb
modified:   app/policies/comment_policy.rb
new file:   app/serializers/comment_for_post_show_serializer.rb
modified:   app/serializers/comment_index_serializer.rb
new file:   app/serializers/comment_show_serializer.rb
modified:   app/serializers/post_index_serializer.rb
modified:   app/serializers/post_show_serializer.rb
modified:   spec/requests/comments_request_spec.rb
modified:   spec/requests/posts_request_spec.rb
modified:   spec/support/object_creators.rb
```

## EPISODE 20 - comments model

```
rails g migration createComments
```

```
rails db:migrate
```

files
```
#	modified:   README.md
#	new file:   app/controllers/api/v1/comments_controller.rb
#	new file:   app/models/comment.rb
#	new file:   app/models/concerns/abilities/commentable.rb
#	new file:   app/models/concerns/comments/associations.rb
#	new file:   app/models/concerns/comments/logic.rb
#	new file:   app/models/concerns/comments/validations.rb
#	modified:   app/models/concerns/users/associations.rb
#	new file:   app/models/concerns/users/logic.rb
#	modified:   app/models/post.rb
#	modified:   app/models/user.rb
#	new file:   app/policies/comment_policy.rb
#	new file:   app/serializers/comment_index_serializer.rb
#	modified:   app/serializers/post_index_serializer.rb
#	modified:   app/serializers/post_show_serializer.rb
#	modified:   config/locales/en.yml
#	modified:   config/routes.rb
#	new file:   db/migrate/20210422213742_create_comments.rb
#	modified:   db/schema.rb
#	new file:   spec/requests/comments_request_spec.rb
#	modified:   spec/support/object_creators.rb
```

## EPISODE 19 - fix user validations and post slugs

```
rails g migration addSlugToPosts
```

FILES
```
modified:   app/controllers/api/v1/posts_controller.rb
modified:   app/models/concerns/users/validations.rb
modified:   app/models/post.rb
modified:   app/models/user.rb
modified:   app/serializers/post_show_serializer.rb
modified:   config/locales/en.yml
modified:   config/routes.rb
new file:   db/migrate/20210422212211_add_slug_to_posts.rb
modified:   db/schema.rb
modified:   spec/requests/posts_request_spec.rb
```

```
Post.find_each(&:save)
```

## EPISODE 18 - friendly URLs via the friendly gem

* https://github.com/norman/friendly_id

```
rails g migration AddSlugToUsers slug:uniq
```

Files
```
#	modified:   Gemfile
#	modified:   Gemfile.lock
#	modified:   README.md
#	modified:   app/controllers/api/v1/posts_controller.rb
#	modified:   app/controllers/api/v1/users_controller.rb
#	modified:   app/controllers/application_controller.rb
#	modified:   app/models/concerns/posts/logic.rb
#	modified:   app/models/concerns/posts/validations.rb
#	modified:   app/models/user.rb
#	modified:   app/policies/post_policy.rb
# modified:   app/serializers/post_index_serializer.rb
#	new file:   app/serializers/user_show_serializer.rb
#	new file:   config/initializers/friendly_id.rb
#	modified:   config/routes.rb
#	new file:   db/migrate/20210414181412_add_slug_to_users.rb
#	modified:   db/schema.rb
#	modified:   spec/requests/posts_request_spec.rb
#	modified:   spec/requests/users_request_spec.rb
#
```

After, rails console:
```
User.find_each(&:save)
```


## EPISODE 17 - cookies

## EPISODE 16 - create/update/delete posts

```
Gemfile
app/controllers/api/v1/posts_controller.rb
app/controllers/application_controller.rb
app/models/post.rb
app/models/concerns/posts/logic.rb
app/policies/application_policy.rb
app/policies/post_policy.rb
app/serializers/post_index_serializer.rb
app/serializers/post_show_serializer.rb
config/locales/en.yml
config/routes.rb
spec/requests/posts_request_spec.rb
spec/support/object_creators.rb
```

## EPISODE 15 - creating a blog

```
rails g migration createPosts
rake db:migrate
```

Files
```
db/migrations/XXX_create_posts.rb
app/models/post.rb
app/models/user.rb
app/models/concerns/posts/associations.rb
app/models/concerns/posts/validations.rb
app/models/concerns/users/associations.rb
app/models/concerns/users/validations.rb
config/routes.rb
spec/requests/posts_request_spec.rb
spec/support/object_creators.rb
```

## EPISODE 14

Backend, and why using localStorage:
https://github.com/waiting-for-dev/devise-jwt/issues/126

tldr;
* cannot use different domains.
* long-term, we'll be using the same APIs with our mobile app.
* update to check and compare/use the AUD

Concerns
* XSS

```
config/initializers/cors.rb
models/concerns/users/allowlist.rb
controllers/sessions_controller.rb
```

## EPISODE 13

```
routes.rb
controllers/api/v1/users_controller.rb
en.yml
models/user.rb
spec/requests/users_request_spec.rb
```

## EPISODE 12

Adding usernames:
```
migration > rails g migration addNamesThemesToUser
config/initializers/devise.rb
controllers/application_controller.rb
model/user.rb
views/devise/mailer/confirmation_instructions.html.erb
```

Fixing specs:
```
spec/support/object_creators.rb
```

Changes:
```
config/environments/development.rb (port)
```

Upcoming:
```
config/routes.rb
controllers/api/v1/users_controller.rb
spec/requests/users_request_spec.rb
```

## EPISODE 11

In heroku, add Mailgun addon.

Under environment variables, add each:

```
MAILGUN_SMTP_LOGIN -> MAIL_PROVIDER_USERNAME
MAILGUN_SMTP_PASSWORD -> MAIL_PROVIDER_PASSWORD
MAILGUN_SMTP_PORT -> MAIL_PROVIDER_PORT
MAILGUN_SMTP_SERVER -> MAIL_PROVIDER_ADDRESS
```

Delete the old MAILGUN_X ones.

In Mailgun, add your email to authorized emails + confirm it.

## EPISODE 10

Promote to production

heroku run rails db:migrate -a ptil-rails-api
heroku run rails c -a ptil-rails-api

Addons:
* Bug Tracking - Honeybadger
* Performance / Monitoring - Librato
* Performance / Monitoring - New Relic
* Logging - Logentries
* Redis - Redis Enterprise Cloud
* Cron - Heroku Scheduler

## EPISODE 9

Create Heroku account
Install setup Heroku CLI
Create pipeline
Create staging application
Create production application

Install add-ons:
* Heroku Postgres

ENV variables:
* DEVISE_JWT_SECRET_KEY
* RACK_ENV
* RAILS_ENV
* RAILS_LOG_TO_STDOUT
* RAILS_SERVE_STATIC_FILES
* SECRET_KEY_BASE

Procfile

heroku git:remote -a ptil-rails-staging-api
git push heroku ep9:master

heroku run rails db:migrate -a ptil-rails-staging-api
heroku run rails c -a ptil-rails-staging-api

## EPISODE 8

config/initializers/cors.rb
```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

Gemfile
```ruby
  # Local Emails
  # https://github.com/ryanb/letter_opener
  gem 'letter_opener'
```

config/environments/development.rb
```ruby
  config.action_mailer.default_url_options = { host: 'localhost', port: 5000 }
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.perform_deliveries = true
```

## EPISODE 7

Github Actions

database.yml
```yml
test:
  <<: *default
  database: programmingtil_rails_1_test
  password: <%= ENV['POSTGRES_PASSWORD'] %>
  username: <%= ENV['POSTGRES_USER'] %>
  host: 127.0.0.1
```

.github/workflows/run_specs.yml
```yml
env:
  RUBY_VERSION: 3.0.0
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: postgres
  POSTGRES_DB: programmingtil_rails_1_test
  DEVISE_JWT_SECRET_KEY: ${{ secrets.DEVISE_JWT_SECRET_KEY }}

name: Rails Specs
on: [push,pull_request]
jobs:
  rspec-test:
    name: RSpec
    runs-on: ubuntu-20.04
    services:
      postgres:
        image: postgres:latest
        ports:
        - 5432:5432
        env:
          POSTGRES_USER: ${{ env.POSTGRES_USER }}
          POSTGRES_PASSWORD: ${{ env.POSTGRES_PASSWORD }}
    steps:
      - uses: actions/checkout@v1
      - uses: actions/setup-ruby@v1
        with:
          ruby-version: ${{ env.RUBY_VERSION }}
      - name: Install postgres client
        run: sudo apt-get install libpq-dev
      - name: Install dependencies
        run: |
          gem install bundler
          bundler install
      - name: Create database
        run: |
          bundler exec rails db:create RAILS_ENV=test
          bundler exec rails db:migrate RAILS_ENV=test
      - name: Run tests
        run: bundler exec rspec spec/*
      - name: Upload coverage results
        uses: actions/upload-artifact@master
        if: always()
        with:
          name: coverage-report
          path: coverage
```

## EPISODE 6

```ruby
  gem 'simplecov', require: false
```
## EPISODE 5

Gemfile
```ruby
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
```

routes.rb
```ruby
  # Ping to ensure site is up
  resources :ping, only: [:index] do
    collection do
      get :auth
    end
  end
```

en.yml
```yml
en:
  controllers:
    confirmations:
      resent: "Confirmation email sent successfully."
      success: "Email confirmed successfully."
    passwords:
      email_required: "Email is required."
      email_sent: "Email sent. Please check your inbox."
      success: "Password updated successfully. You may need to sign in again."
    registrations:
      confirm: "Please confirm your email address."
    sessions:
      sign_out: "Signed out successfully."
```

application_controllerb.rb
confirmations_controller.rb
passwords_controller.rb
registrations_controller.rb
sessions_controller.rb

ping_controller.rb
```ruby
class PingController < ApplicationController
  before_action :authenticate_user!, only: [:auth]

  # GET /ping
  def index
    render body: nil, status: 200
  end

  # GET /ping/auth
  def auth
    render body: nil, status: 200
  end
end
```

ping_request_spec.rb
```ruby
require 'rails_helper'

RSpec.describe "Pings", type: :request do
  it 'Returns a status of 200' do
    get '/ping/'
    expect(response).to have_http_status(200)
  end

  it 'Returns a status of 401 if not logged in' do
    get '/ping/auth/'
    expect(response).to have_http_status(401)
  end

  it 'Returns a status of 200 if logged in' do
    user = create_user
    headers = get_headers(user.username)

    get '/ping/auth/', headers: headers
    expect(response).to have_http_status(200)
  end
end
```

devise.rb
```ruby
  config.warden do |manager|
    manager.failure_app = DeviseCustomFailure
  end
```

application.rb
lib/DeviseCustomFailure.rb
models/user.rb

## EPISODE 4

Gemfile
```ruby
  # Annotate models and more
  # https://github.com/ctran/annotate_models
  gem 'annotate'
```

```
bundle install
```

auto_annotate_models.rake
```ruby
# NOTE: only doing this in development as some production environments (Heroku)
# NOTE: are sensitive to local FS writes, and besides -- it's just not proper
# NOTE: to have a dev-mode tool do its thing in production.
if Rails.env.development?
  require 'annotate'
  task :set_annotation_options do
    # You can override any of these by setting an environment variable of the
    # same name.
    Annotate.set_defaults(
      'active_admin'                => 'false',
      'additional_file_patterns'    => [],
      'routes'                      => 'false',
      'models'                      => 'true',
      'position_in_routes'          => 'before',
      'position_in_class'           => 'before',
      'position_in_test'            => 'before',
      'position_in_fixture'         => 'before',
      'position_in_factory'         => 'before',
      'position_in_serializer'      => 'before',
      'show_foreign_keys'           => 'true',
      'show_complete_foreign_keys'  => 'false',
      'show_indexes'                => 'true',
      'simple_indexes'              => 'false',
      'model_dir'                   => 'app/models',
      'root_dir'                    => '',
      'include_version'             => 'false',
      'require'                     => '',
      'exclude_tests'               => 'false',
      'exclude_fixtures'            => 'true',
      'exclude_factories'           => 'true',
      'exclude_serializers'         => 'true',
      'exclude_scaffolds'           => 'true',
      'exclude_controllers'         => 'true',
      'exclude_helpers'             => 'true',
      'exclude_sti_subclasses'      => 'false',
      'ignore_model_sub_dir'        => 'false',
      'ignore_columns'              => nil,
      'ignore_routes'               => nil,
      'ignore_unknown_models'       => 'false',
      'hide_limit_column_types'     => 'integer,bigint,boolean',
      'hide_default_column_types'   => 'json,jsonb,hstore',
      'skip_on_db_migrate'          => 'false',
      'format_bare'                 => 'true',
      'format_rdoc'                 => 'false',
      'format_yard'                 => 'false',
      'format_markdown'             => 'false',
      'sort'                        => 'false',
      'force'                       => 'false',
      'frozen'                      => 'false',
      'classified_sort'             => 'false',
      'trace'                       => 'false',
      'wrapper_open'                => nil,
      'wrapper_close'               => nil,
      'with_comment'                => 'true'
    )
  end

  Annotate.load_tasks
end
```

```
rake db:migrate
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

## EPISODE 1:
```
rails new programmingtil-rails-1 --api --database=postgresql
```
