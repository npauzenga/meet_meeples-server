class GroupsController < AuthenticationController
  def create
    result = CreateGroup.call(group_params)

    if result.success?
      render json: result.group, status: :created
    else
      render json: result.group.errors, status: :unprocessable_entity
    end
  end

  def show
    result = ShowGroup.call(id: params[:id])

    if result.success?
      render json: result.group, status: :ok
    else
      render json: result.errors, status: :not_found
    end
  end

  def update
    result = UpdateGroup.call(group_params)

    if result.success?
      render json: result.group, status: :ok
    else
      render json: result.group.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = DeleteGroup.call(id: params[:id])
    unless result.success?
      render json: result.errors, status: :internal_server_error
    end
  end

  private

  def group_params
    params.require(:group).permit(:name,
                                  :city,
                                  :state,
                                  :country,
                                  :facebook,
                                  :twitter)
  end
end
