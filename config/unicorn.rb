app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
working_directory app_dir

worker_processes ENV['UNICORN_WORKER_PROCESSES'].to_i
preload_app true
timeout ENV['UNICORN_TIMEOUT'].to_i

listen "#{shared_dir}/sockets/unicorn.sock", backlog: 64
# listen "#{ENV['UNICORN_HOST']}:#{ENV['UNICORN_PORT']}", tcp_nopush: true

stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

pid "#{shared_dir}/pids/unicorn.pid"
