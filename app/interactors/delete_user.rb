class DeleteUser < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.id
  end

  def execute
    context.user = User.find(context.id).destroy
  end

  def validate_output
    context.fail!(errors: "user not deleted") unless context.user.destroyed?
  end
end
