class DeleteUser
  include Interactor

  def call
    validate_input
    execute
    validate_output
  end

  private

  def validate_input
    context.fail!(errors: MissingParamsError.new) unless context.id
  end

  def execute
    context.user = User.find(context.id).destroy
  end

  def validate_output
    context.fail!(errors: InternalServerError.new) unless context.user.destroyed?
  end
end
