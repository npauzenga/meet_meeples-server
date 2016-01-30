class ShowGroup < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.id
  end

  def execute
    context.group = Group.find_by(id: context.id)
  end

  def validate_output
    context.fail!(errors: "invalid output") unless context.group
  end
end
