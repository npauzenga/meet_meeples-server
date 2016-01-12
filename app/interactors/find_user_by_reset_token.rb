class FindUserByResetToken < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.reset_token
  end

  def execute
    context.user = User.find_by(reset_digest: digest_token)
  end

  def validate_output
    context.fail!(errors: "invalid output") unless context.user
  end

  private

  def digest_token
    Encryptor.digest_token(context.reset_token)
  end
end
