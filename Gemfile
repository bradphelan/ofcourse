source 'http://rubygems.org'

gem 'rails', '3.0.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'declarative_authorization'

gem 'devise'

# Keep this until my pull request
# https://github.com/sferik/rails_admin/pull/282
# is accepted
#gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'rails_admin', :git => 'git://github.com/bradphelan/rails_admin.git'

gem 'ckeditor', :git => 'git://github.com/galetahub/rails-ckeditor.git', :branch => 'rails3'
gem 'paperclip'


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
gem "rails3-generators"
gem "haml-rails"
gem "jquery-rails"
gem "haml"
gem "rspec-rails", ">= 2.0.0.beta.19", :group => [:development, :test, :cucumber]
gem "factory_girl_rails", :group => [:test, :cucumber]
gem "remarkable_activemodel", ">=4.0.0.alpha4", :group => :test
gem 'formtastic', '~> 1.1.0'

group :cucumber do
  gem 'capybara'
  gem 'cucumber-rails'
  gem 'spork'
  gem 'launchy'
end

group :development do
  gem "rails-erd"

  gem 'spork'
  gem 'rb-fsevent'
  gem 'guard-spork'
  gem 'rb-inotify'

  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-sass'
end

gem "compass"
gem "compass-susy-plugin"
gem "rdiscount"
