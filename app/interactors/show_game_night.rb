class ShowGameNight < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.id
  end

  def execute
    context.game_night = GameNight.find(context.id)
  end
end
