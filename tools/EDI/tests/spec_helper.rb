require_relative '../../../config/environment'
require 'minitest/autorun'
require 'dotenv'

Dotenv.load!(File.expand_path('../../../../.env.test', __FILE__))
ENV['HANAMI_ENV'] = 'test'
ENV['DATABASE_URL'] = 'sqlite://db/assoc_test.sqlite'
Hanami.boot
