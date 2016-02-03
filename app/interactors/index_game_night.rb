class IndexGameNight < StandardInteraction
  def execute
    context.game_nights = GameNight.all
  end

  def validate_output
    context.fail!(errors: "internal server error") unless context.game_nights
  end
end
