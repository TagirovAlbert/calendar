source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
#for getting attr-accessible
gem 'protected_attributes'
#auth user in site
gem 'devise'

gem 'omniauth'
gem 'omniauth-facebook'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
#connect bootstrap styles
gem 'bootstrap-sass'
#view calendar method
gem 'calendar_helper'
#for event every day, every week ....
gem 'recurrence'
#for dependent checkboxes
gem 'dependent-fields-rails'


#use for testing sending confirmation instructions
#gem 'mailcatcher'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # for load enviroment variables from .env to ENV
  gem 'dotenv-rails'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  #for check ruby grammar
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  #for tests
  gem 'rspec-rails'

end

group :development do
  gem 'guard'
  #run bundle install
  gem 'guard-bundler', require: false
  #auto run test rspec
  gem 'guard-rspec'
  #auto start rails server
  gem 'guard-rails'
  #run migrations
  gem 'guard-migrate'



end

group :production do

  gem 'rails_12factor'
end


