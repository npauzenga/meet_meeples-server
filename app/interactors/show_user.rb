class ShowUser
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
    context.user = User.find_by(id: context.id)
  end

  def validate_output
    context.fail!(errors: UserNotFound.new) unless context.user
  end
end
