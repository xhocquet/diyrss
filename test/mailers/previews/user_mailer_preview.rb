# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def daily_report
    user = User.first
    UserMailer.daily_report(user: user)
  end
end
