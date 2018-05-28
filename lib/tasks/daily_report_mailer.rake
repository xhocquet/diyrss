namespace :reports do
  task :daily => [ :environment ]  do
    UserProfile.where(notify_email: true).includes(:user).find_each do |up|
      UserMailer.daily_report(user: up.user).deliver_later
    end
  end
end
