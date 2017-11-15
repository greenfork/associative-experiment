working_directory '{{pkg.path}}/app'

worker_processes {{cfg.unicorn.worker_processes}}
preload_app {{cfg.unicorn.preload_app}}
timeout {{cfg.unicorn.timeout}}

# listen '{{pkg.svc_var_path}}/shared/sockets/unicorn.sock', :backlog => 64
listen '{{cfg.server.host}}:{{cfg.server.port}}', :tcp_nopush => true

stderr_path '{{pkg.svc_var_path}}/shared/log/unicorn.stderr.log'
stdout_path '{{pkg.svc_var_path}}/shared/log/unicorn.stdout.log'

pid '{{pkg.svc_var_path}}/shared/pids/unicorn.pid'
