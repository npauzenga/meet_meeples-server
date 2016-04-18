class CreateUser < StandardInteraction
  def validate_input(input: :user_params)
    super
  end

  def execute
    context.user = User.create(context.user_params)
  end

  def validate_output
    context.fail!(errors: context.user.errors) unless context.user.persisted?
  end
end
