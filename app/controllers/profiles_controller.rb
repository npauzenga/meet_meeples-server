class ProfilesController < AuthenticationController
  # GET /profiles/1
  def show
    result = ShowProfile.call(id: params[:id])
    if result.success?
      render json: result.user, status: :ok
    else
      render json: result.error, status: :not_found
    end
  end

  # GET /profiles
  def index
    
  end
end
