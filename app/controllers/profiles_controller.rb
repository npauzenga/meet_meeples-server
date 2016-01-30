class ProfilesController < AuthenticationController
  # GET /profiles/1
  def show
    result = ShowProfile.call(id: params[:id])

    if result.success?
      render json: result.user, status: :ok
    else
      render json: result.errors, status: :not_found
    end
  end

  # GET /profiles
  def index
    result = IndexProfile.call

    if result.success?
      render json: result.profiles, status: :ok
    else
      render json: result.errors, status: :internal_server_error
    end
  end
end
