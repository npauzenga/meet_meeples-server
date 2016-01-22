class CreateGroup < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.group_params
  end

  def execute
    context.group = Group.create(context.group_params)
  end

  def validate_output
    context.fail!(errors: context.group.errors) unless context.group.persisted?
  end
end
