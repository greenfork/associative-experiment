require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false
end

task :server do
  port = ENV['PORT'] ? ENV['PORT'] : '7000'
  environment = ENV['HANAMI_ENV'] ? ENV['HANAMI_ENV'] : 'development'
  `HANAMI_ENV=#{environment} unicorn --port #{port}`
end

task default: :test
task spec: :test
task s: :server
