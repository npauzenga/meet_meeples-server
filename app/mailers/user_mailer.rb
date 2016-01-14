class UserMailer < ActionMailer::Base
  default from: "admin@meetmeeples.com"

  def password_reset(user)
    @user = user
    @first_name = user.first_name

    mail(to:      "#{@user.email}",
         subject: "Meet Meeples Password Reset")
  end
end
