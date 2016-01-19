class ShowUser < StandardInteraction
  def validate_input
    context.fail!(error: "invalid user id") unless context.id
  end

  def execute
    context.user = User.find(context.id)
  end
end
