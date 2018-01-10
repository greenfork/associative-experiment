source 'https://rubygems.org'

ruby '2.4.2'

gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
gem 'hanami', '1.1.0'
gem 'hanami-bootstrap'
gem 'hanami-model', '1.1.0'
gem 'i18n', '~> 0.8.6'
gem 'jquery-hanami'
gem 'rake'
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
  gem 'mysql2', '~> 0.4.9'
  gem 'unicorn'
  gem 'uglifier'
end
