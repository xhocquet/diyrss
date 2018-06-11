rails_env = ENV['RAILS_ENV'] || 'development'
rails_root = File.expand_path("../", File.dirname(__FILE__))

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

case rails_env
  when 'production'
    port 80
    daemonize true
  when 'development'
    port 3000
  else
end

environment ENV.fetch("RAILS_ENV") { "development" }

pidfile "tmp/pids/puma.pid"

plugin :tmp_restart
