class CreateGameNight < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.resource = create_game_night
  end

  def validate_output
    context.fail!(errors: context.resource.errors) unless game_night_saved?
  end

  private

  def game_night_saved?
    context.resource.persisted?
  end

  def valid_input?
    context.game_night_params && context.user
  end

  def create_game_night
    context.user.game_nights.create(context.game_night_params)
  end
end
