class UpdateUser < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.user && context.user_params
  end

  def execute
    context.fail!(errors: context.user.errors) unless update_user
  end

  private

  def update_user
    context.user.update(context.user_params)
  end
end
