class CreateGroupMembership < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.membership = UserGroupMembership.create(user_id:  context.user_id,
                                                    group_id: context.group_id)
  end

  def validate_output
    context.fail!(errors: context.membership.errors) unless membership_saved?
  end

  private

  def valid_input?
    context.user_id && context.group_id
  end

  def membership_saved?
    context.membership.persisted?
  end
end
