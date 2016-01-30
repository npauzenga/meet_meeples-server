class UsersController < AuthenticationController
  skip_before_action :authenticate, only: :create

  # POST /users
  def create
    result = CreateUser.call(user_params: user_params)

    if result.success?
      token = CreateAuthToken.call(user: result.user).token
      render json: { jwt: token }, status: :created
    else
      render json: result.user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/1
  def show
    result = ShowUser.call(id: params[:id])

    if result.success?
      render json: result.user, status: :ok
    else
      render json: result.errors, status: :not_found
    end
  end

  # PATCH /users/1
  def update
    result = UpdateUser.call(user: current_user, user_params: user_params)

    if result.success?
      render json: result.user, status: :ok
    else
      render json: result.user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    result = DeleteUser.call(id: current_user.id)

    if result.success?
      head :no_content
    else
      render json: result.errors, status: :internal_server_error
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :email,
                                 :last_name,
                                 :city,
                                 :state,
                                 :country,
                                 :password)
  end
end
