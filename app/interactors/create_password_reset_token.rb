class CreatePasswordResetToken < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.user
  end

  def execute
    context.user.update(reset_digest: Encryptor.generate_token[0])
  end

  def validate_output
    context.fail!(errors: "server error") unless context.user.reset_digest
  end
end
