class UsersController < AuthenticationController
  skip_before_action :authenticate, only: :create

  # POST /user
  def create
    result = CreateUser.call(user_params: user_params)

    if result.success?
      token = CreateAuthToken.call(user: result.user).token
      render json: { jwt: token }, status: :created
    else
      render json: result.user.errors, status: :unprocessable_entity
    end
  end

  # PATCH /user
  def update
    result = UpdateUser.call(user: current_user, params: user_params)

    if result.success?
      render json: result.user, status: :ok
    else
      render json: result.user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user
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
