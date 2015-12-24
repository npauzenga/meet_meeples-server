class UpdateUser
  include Interactor

  def call
    validate_input
    execute
  end

  private

  def validate_input
    context.fail!(error: "invalid input") unless context.user && context.params
  end

  def execute
    context.fail!(errors: context.user.errors) unless update_user
  end

  private

  def update_user
    context.user.update(context.params.fetch(:user))
  end
end
