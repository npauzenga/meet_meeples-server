class CreateUser < StandardInteraction
  def validate_input
    context.fail!(errors: MissingParamsError.new) unless context.user_params
  end

  def execute
    context.user = User.create(context.user_params)
  end

  def validate_output
    context.fail!(errors: context.user.errors) unless context.user.persisted?
  end
end
