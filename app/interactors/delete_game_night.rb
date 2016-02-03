class DeleteGameNight < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless context.id
  end

  def execute
    context.game_night = GameNight.destroy(context.id)
  end

  def validate_output
    context.fail!(errors: "game night not deleted") unless game_night_destroyed?
  end

  private

  def game_night_destroyed?
    context.game_night.destroyed?
  end
end
