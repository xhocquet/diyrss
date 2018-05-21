task :clear_dead_jobs => [ :environment ]  do
  ss = Sidekiq::ScheduledSet.new
  ids = AppMonitor.ids

  ss.each do |job|
    job.delete unless ids.include? job.args[0]
  end
end
