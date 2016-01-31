class GroupsController < AuthenticationController
  # POST /groups
  def create
    result = CreateGroup.call(user: current_user, group_params: group_params)

    if result.success?
      render json: result.group, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  # GET /groups/:id
  def show
    result = ShowGroup.call(id: params[:id])

    if result.success?
      render json: result.group, status: :ok
    else
      render json: result.errors, status: :not_found
    end
  end

  # PATCH /groups/:id
  def update
    result = UpdateGroup.call(id: params[:id], group_params: group_params)

    if result.success?
      render json: result.group, status: :ok
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  # GET /groups
  def index
    result = IndexGroup.call

    if result.success?
      render json: result.groups, status: :ok
    else
      render json: result.errors, status: :internal_server_error
    end
  end

  # DELETE /groups/:id
  def destroy
    result = DeleteGroup.call(id: params[:id])

    if result.success?
      head :no_content
    else
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
