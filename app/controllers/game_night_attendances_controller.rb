class GameNightAttendancesController < AuthenticationController
  # POST /game_nights/:game_night_id/game_night_attendences
  def create
    result = CreateGameNightAttendance.call(user_id:       current_user.id,
                                            game_night_id: params[:game_night_id])
    if result.success?
      head :no_content
    else
      render json: result.errors, status: :internal_server_error
    end
  end
end
