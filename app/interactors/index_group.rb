class IndexGroup < StandardInteraction
  def execute
    context.groups = Group.all
  end

  def validate_output
    context.fail!(errors: "internal server error") unless context.groups
  end
end
