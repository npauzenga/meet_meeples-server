class GroupMembershipsController < AuthenticationController
  # POST /groups/:group_id/group_memberships
  def create
    result = CreateGroupMembership.call(user_id:  current_user.id,
                                        group_id: params[:group_id])
    if result.success?
      head :no_content
    else
      render json: result.errors, status: :internal_server_error
    end
  end
end
