class CreateAuthToken < StandardInteraction
  def validate_input
    context.fail! unless context.user
  end

  def execute
    context.token = Knock::AuthToken.new(payload: { sub: context.user.id })
  end

  def validate_output
    context.fail! unless context.token
  end
end
