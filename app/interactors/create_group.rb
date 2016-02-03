class CreateGroup < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.resource = context.user.groups.create(context.group_params)
  end

  def validate_output
    context.fail!(errors: context.resource.errors) unless resource_persisted?
  end

  private

  def resource_persisted?
    context.resource.persisted?
  end

  def valid_input?
    context.group_params && context.user
  end
end
