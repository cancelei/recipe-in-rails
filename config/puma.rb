# Set the number of Puma workers. This depends on your app's workload and the available resources.
# WEB_CONCURRENCY environment variable can be used to configure this dynamically.
workers Integer(ENV['WEB_CONCURRENCY'] || 2)

# Threads count settings can increase concurrency. Here, we set a minimum and maximum.
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

# Preload the application before spawning workers. This can reduce startup time and memory usage.
# However, it requires that your application be thread-safe.
preload_app!

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port        ENV['PORT'] || 3000

# Specifies the `environment` that Puma will run in.
environment ENV['RACK_ENV'] || 'development'

# On worker boot, this block will be run. If you're using Rails 4.1+,
# you don't actually need this block unless you're doing something special.
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# Additional configuration options can be set here.
# For example, you can specify where to store Puma's PID file and state file:
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
state_path "tmp/pids/puma.state"

# You can also specify a location for the log files:
stdout_redirect("log/puma.stdout.log", "log/puma.stderr.log", true)

# If using phased restart feature of Puma, use this to define the code to run
# before a new worker is forked. This is a good place to connect to new database
# connections or other service connections.
before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end
