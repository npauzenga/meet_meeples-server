class UpdatePassword
  include Interactor

  def call
    validate_input
    execute
    validate_output
  end

  def validate_input
    # TODO replace with Error object
    context.fail!(errors: "invalid input") unless context.user && context.password 
  end

  def execute
    context.user.update(password: context.password, reset_digest: nil)
  end

  def validate_output
    # TODO replace with Error object
    context.fail!(errors: "internal server error") unless passwords_match?
  end

  private

  # TODO move to Encryptor class?
  def passwords_match?
    context.user.password == context.password
  end
end
