class GameNightsController < AuthenticationController
  def create
    result = CreateModel.call(active_record_class: GameNight,
                              model_params:        game_night_params)

    if result.success?
      render json: result.model, status: :created
    else
      render json: result.model.errors, status: :unprocessable_entity
    end
  end

  def update
    result = UpdateModel.call(active_record_class: GameNight,
                              id:                  params[:id],
                              model_params:        game_night_params)

    if result.success?
      render json: result.model, status: :ok
    else
      render json: result.model.errors, status: :unprocessable_entity
    end
  end

  def show
    result = ShowModel.call(active_record_class: GameNight,
                            id:                  params[:id])

    if result.success?
      render json: result.model, status: :ok
    else
      render json: result.errors, status: :not_found
    end
  end

  def destroy
    result = DeleteModel.call(active_record_class: GameNight,
                              id:                  params[:id])

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
