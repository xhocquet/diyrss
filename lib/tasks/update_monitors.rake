task :update_monitors => [ :environment ]  do
  AppMonitor.all.find_each do |monitor|
    AppMonitorWorker.perform_async(monitor.id)
  end
end
