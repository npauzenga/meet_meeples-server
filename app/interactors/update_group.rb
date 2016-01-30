class UpdateGroup < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.fail!(errors: "group update failed") unless update_group
  end

  private

  def update_group
    Group.update(context.id, context.group_params)
  end

  def valid_input?
    context.group_params && context.id
  end
end
