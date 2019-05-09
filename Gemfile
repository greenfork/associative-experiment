source 'https://rubygems.org'

ruby '2.6.3'

gem 'hanami', '~> 1.3'
gem 'hanami-bootstrap', '0.4.0'
gem 'hanami-model', '~> 1.3'
gem 'sequel'
gem 'i18n', '~> 0.8.6'
gem 'jquery-hanami'
gem 'rake'
gem 'rubyXL'
gem 'sass'
gem 'tachiban'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'rubocop', require: false
  gem 'shotgun'
end

group :test, :development do
  gem 'byebug'
  gem 'dotenv', '~> 2.0'
  gem 'pry'
  gem 'pry-byebug'
  gem 'sqlite3'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'minitest'
end

group :production do
  # gem 'mysql2', '~> 0.4.9'
  gem 'pg'
  gem 'unicorn'
  gem 'uglifier'
end
