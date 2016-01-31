class CreateGroup < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.group = context.user.groups.create(context.group_params)
  end

  def validate_output
    context.fail!(errors: context.group.errors) unless context.group.persisted?
  end

  private

  def valid_input?
    context.group_params && context.user
  end
end
