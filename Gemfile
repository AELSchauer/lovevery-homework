source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 6.0.0'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'migration_data'
gem 'email_validator'

#added these to address vulnerabilities
gem "nokogiri", ">= 1.10.8"
gem "actionview", ">= 6.0.2.2"

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'factory_bot_rails'
  gem "byebug", "~> 11.1"
  gem 'faker'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
  gem 'factory_bot_rails'
  gem "byebug", "~> 11.1"
  gem 'faker'
end

gem "rspec-rails", groups: [ :development, :test ]

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

