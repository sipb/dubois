source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'activeresource'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
# Bootstrappyness
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass', '~> 3.1.1'

gem 'redcarpet'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Interface with email
gem 'mail', require: 'mail'

# MIT Ldap
gem 'mit-ldap', require: 'mit-ldap'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# HTTP Client
gem 'faraday'

# HeliotropeClient Dependencies
gem 'curb'
gem 'lrucache'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do

  # Pretty debugging
  gem 'jazz_hands'

  # Useful when running dubois via Pow
  gem 'pry-remote'
  
  # Better error pages, with an inline REPL and such.
  gem 'better_errors'
  gem "binding_of_caller"

  # Testing.
  gem 'rspec-rails'

  # Environment variables for development
  gem 'dotenv-rails'
end

group :test do
  # "after_commit" callbacks will never be invoked by default during testing. This fixes that.
  gem 'test_after_commit'
end
