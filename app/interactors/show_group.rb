class ShowGroup < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.id
  end

  def execute
    context.group = Group.find(context.id)
  end
end
