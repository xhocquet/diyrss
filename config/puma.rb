rails_env = ENV['RAILS_ENV'] || 'development'
rails_root = File.expand_path("../", File.dirname(__FILE__))

case rails_env
  when 'production'
    port 80
    daemonize true
  when 'development'
    port 3000
  else
end

threads 1,4
preload_app!

environment ENV.fetch("RAILS_ENV") { "development" }

pidfile "tmp/pids/puma.pid"

plugin :tmp_restart
