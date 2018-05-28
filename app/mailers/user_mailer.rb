class UserMailer < ApplicationMailer
  default from: "notifications@diyrss.info"

  def daily_report(user:)
    @user = user
    @notifications = user.notifications.unread
    @subject = "Fresh updates!"

    mail( to: @user.email, subject: @subject )
  end
end
