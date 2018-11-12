source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2'
gem 'pg'
gem 'puma'
gem 'bcrypt'
gem 'uglifier'
gem 'bootsnap', require: false
gem 'draper'
gem 'kaminari'
gem 'email_validator'
gem 'rails_12factor', group: :production
gem 'validates_timeliness', '~> 5.0.0.alpha3'
gem 'rails-observers'

group :development, :test do
  gem 'simplecov'
  gem 'rspec-rails'
  gem 'pry-byebug'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'database_rewinder'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-collection_matchers'
  gem 'shoulda-callback-matchers'
  gem 'rails-controller-testing'
end
