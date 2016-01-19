class UpdateUser < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.user && context.params
  end

  def execute
    context.fail!(errors: InvalidParamsError.new) unless update_user
  end

  def update_user
    context.user.update(context.params.fetch(:user))
  end
end
