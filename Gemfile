source 'https://rubygems.org'

gem 'hanami', '1.1.0.rc1'
gem 'hanami-bootstrap'
gem 'hanami-model', '1.1.0.rc1'
gem 'i18n', '~> 0.8.6'
gem 'jquery-hanami'
gem 'rake'
gem 'sqlite3'
gem 'tachiban'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'byebug'
  gem 'dotenv', '~> 2.0'
  gem 'pry'
  gem 'pry-byebug'
end

group :test do
  gem 'capybara'
  gem 'minitest'
  gem 'selenium-webdriver', '~> 3.5', '>= 3.5.2'
  gem 'capybara-webkit'
end

group :production do
  # gem 'puma'
end
