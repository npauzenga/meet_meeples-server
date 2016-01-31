class AddRoleToUser < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.user.add_role context.role, context.resource
  end

  def validate_output
    context.fail!(errors: "invalid output") unless rolified?
  end

  private

  def rolified?
    context.user.has_role? context.role, context.resource
  end

  def valid_input?
    context.resource && context.user && context.role
  end
end
