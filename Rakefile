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
  `HANAMI_ENV=#{environment} unicorn -l '127.0.0.1:#{port}' -w -E development`
end

task script: :environment do
  # edit for your needs
  $path_to_project = `pwd`.chomp
  basepath = '/home/greenfork/code/assoc_quest/'
  require_relative basepath + 'path/to/script.rb'
end

task default: :test
task spec: :test
task s: :server
