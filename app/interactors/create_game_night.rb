class CreateGameNight < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.game_night_params
  end

  def execute
    context.game_night = GameNight.create(context.game_night_params)
  end

  def validate_output
    context.fail!(errors: context.game_night.errors) unless game_night_saved?
  end

  private

  def game_night_saved?
    context.game_night.persisted?
  end
end
