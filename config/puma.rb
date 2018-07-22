rails_env = ENV['RAILS_ENV'] || 'development'
rails_root = File.expand_path("../", File.dirname(__FILE__))
app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"

case rails_env
  when 'production'
    # port 80
    daemonize true
  when 'development'
    port 3000
  else
end

# Number of cores
workers 2

# Min, max threads
threads 1,6

bind "unix://#{shared_dir}/sockets/puma.sock"

# preload_app!

# Logging
stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

environment ENV.fetch("RAILS_ENV") { "development" }

pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end

