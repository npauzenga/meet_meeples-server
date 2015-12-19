class CreateUser
  include Interactor

  def call
    validate_input
    execute
    validate_output
  end

  private

  def validate_input
    context.fail!(errors: "invalid user params") unless context.user_params
  end

  def execute
    context.user = User.create(context.user_params)
  end

  def validate_output
    context.fail!(errors: context.user.errors) unless context.user.persisted?
  end
end
