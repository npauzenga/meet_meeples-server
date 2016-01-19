class ShowUser < StandardInteraction
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
