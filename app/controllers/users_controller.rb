class UsersController < AuthenticationController
  skip_before_action :authenticate, only: :create
  # valid user creation curl --
  #
  # curl -X POST -F user[first_name]=Nate \
  # -F user[state]=MD -F user[country]=USA \
  # -F user[city]=Annapolis -F user[email]=test@test.com \
  # -F user[last_name]=Bates  -F user[password]=Helloworld \
  # http://localhost:3000/users.json -H "Accept: application/json"

  # curl -i -H "Content-Type: application/json" \
  # -d '{"user": {"email": "test@test.com"}}'

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
      render json: result.error, status: :not_found
    end
  end

  # PATCH /users/1
  def update
    result = UpdateUser.call(user: current_user, params: user_params)
    if result.success?
      render json: result.user, status: :ok
    else
      render json: result.error, status: :internal_server_error
    end
  end

  # DELETE /users/1
  def destroy
    result = DeleteUser.call(id: current_user.id)
    if result.success?
      render json: result.message, status: :ok
    else
      render json: result.error, status: :not_found
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
