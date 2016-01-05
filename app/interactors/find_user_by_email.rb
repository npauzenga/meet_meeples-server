class FindUserByEmail
  include Interactor

  def call
    validate_input
    execute
    validate_output
  end

  private

  def validate_input
    context.fail!(errors: "invalid input") unless context.email
  end

  def execute
    context.user = User.find_by(email: context.email)
  end

  def validate_output
    context.fail!(errors: "invalid user") unless context.user
  end
end
