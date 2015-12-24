class CreateAuthToken
  include Interactor
  def call
    validate_input
    execute
    validate_output
  end

  private

  def validate_input
    context.fail!(errors: MissingParamsError.new) unless context.user
  end

  def execute
    context.token = Knock::AuthToken.new(payload: { sub: context.user.id })
  end

  def validate_output
    context.fail!(errors: InvalidToken.new) unless context.token
  end
end
