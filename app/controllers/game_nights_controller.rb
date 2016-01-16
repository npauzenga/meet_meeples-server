class GameNightsController < AuthenticationController
  def create
    result = CreateGameNight.call(game_night_params)

    if result.success?
      render json: result.game_night, status: :created
    else
      render json: result.game_night.errors, status: :unprocessable_entity
    end
  end

  def update
    result = UpdateGameNight.call(game_night_params)

    if result.success?
      render json: result.game_night, status: :ok
    else
      render json: result.game_night.errors, status: :unprocessable_entity
    end
  end

  def show
    result = ShowGameNight.call(id: params[:id])

    if result.success?
      render json: result.game_night, status: :ok
    else
      render json: result.errors, status: :not_found
    end
  end

  def destroy
    result = DeleteGameNight.call(id: params[:id])

    unless result.success?
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
