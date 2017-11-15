web: bundle exec unicorn -w -c $SVC_FOLDER/config/unicorn.rb
stop: kill -s QUIT `cat $SVC_FOLDER/var/shared/pids/unicorn.pid`
migrate: bundle exec hanami db migrate
