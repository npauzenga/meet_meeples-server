class UpdateGameNight < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.fail!(errors: "game_night update failed") unless update_game_night
  end

  private

  def update_game_night
    GameNight.update(context.id, context.game_night_params)
  end

  def valid_input?
    context.game_night_params && context.id
  end
end
