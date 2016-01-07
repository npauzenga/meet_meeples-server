class UserMailer < ActionMailer::Base
  default from: "admin@meetmeeples.com"

  def password_reset(user)
  end
end
