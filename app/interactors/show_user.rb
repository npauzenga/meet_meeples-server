class ShowUser < StandardInteraction
  def validate_input
    context.fail!(error: "invalid user id") unless context.id
  end

  def execute
    context.user = User.find(context.id)
  rescue ActiveRecord::RecordNotFound
    context.user = nil
  end

  def validate_output
    context.fail!(error: "invalid user") unless context.user
  end
end
