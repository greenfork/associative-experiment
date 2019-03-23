require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/assoc'
require_relative '../apps/research/application'
require_relative '../apps/web/application'
require_relative 'initializers/inflector.rb'
require_relative 'R.rb'
require_relative '../apps/admin/application'

Hanami.configure do
  mount Admin::Application, at: '/admin'
  mount Research::Application, at: '/research'
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/assoc_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/assoc_development'
    #    adapter :sql, 'mysql://localhost/assoc_development'
    #
    adapter :sql, ENV['DATABASE_URL']

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/assoc/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug, filter: %w[password password_confirmation]
  end

  environment :production do
    logger level: :info, formatter: :json

    mailer do
      delivery :smtp, address: ENV['SMTP_HOST'], port: ENV['SMTP_PORT']
    end
  end
end
