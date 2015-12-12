class DeleteUser
  include Interactor

  def call
    validate_input
    execute
  end

  private

  def validate_input
    context.fail!(error: "invalid input") unless context.id
  end

  def execute
    context.user = User.find(context.id)
    context.fail!(error: "user not deleted") unless context.user.destroy
  end
end
