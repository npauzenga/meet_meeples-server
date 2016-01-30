class UpdateUser < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input
  end

  def execute
    context.fail!(errors: context.user.errors) unless update_user
  end

  private

  def valid_input
    context.user && context.user_params
  end

  def update_user
    context.user.update(context.user_params)
  end
end
