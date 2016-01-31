class GameNightsController < AuthenticationController
  # POST /game_nights
  def create
    result = CreateGameNight.call(user:              current_user,
                                  game_night_params: game_night_params)

    if result.success?
      render json: result.game_night, status: :created
    else
      render json: result.game_night.errors, status: :unprocessable_entity
    end
  end

  # PATCH /game_nights
  def update
    result = UpdateGameNight.call(id:                params[:id],
                                  game_night_params: game_night_params)

    if result.success?
      render json: result.game_night, status: :ok
    else
      render json: result.game_night.errors, status: :unprocessable_entity
    end
  end

  # GET /game_nights/:id
  def show
    result = ShowGameNight.call(id: params[:id])

    if result.success?
      render json: result.game_night, status: :ok
    else
      render json: result.errors, status: :not_found
    end
  end

  # GET /game_nights
  def index
    result = IndexGameNight.call

    if result.success?
      render json: result.game_nights, status: :ok
    else
      render json: result.errors, status: :internal_server_error
    end
  end

  # DELETE /game_nights/:id
  def destroy
    result = DeleteGameNight.call(id: params[:id])

    if result.success?
      head :no_content
    else
      render json: result.errors, status: :internal_server_error
    end
  end

  private

  def game_night_params
    params.require(:game_night).permit(:name,
                                       :time,
                                       :location_name,
                                       :location_address)
  end
end
