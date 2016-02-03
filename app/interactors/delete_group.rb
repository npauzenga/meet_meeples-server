class DeleteGroup < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.id
  end

  def execute
    context.group = Group.destroy(context.id)
  end

  def validate_output
    context.fail!(errors: "group not deleted") unless context.group.destroyed?
  end
end
