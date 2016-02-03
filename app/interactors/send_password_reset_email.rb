class SendPasswordResetEmail < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input
  end

  def execute
    context.fail!(errors: "delivery failed") unless send_reset_email
  end

  private

  def send_reset_email
    UserMailer.password_reset(context.user).deliver_now
  end

  def valid_input
    context.user && context.user.reset_digest && context.user.reset_token
  end
end
