class CreateGameNightAttendance < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.attendance = create_game_night_attendance
  end

  def validate_output
    context.fail!(errors: context.attendance.errors) unless attendance_saved?
  end

  private

  def valid_input?
    context.user_id && context.game_night_id
  end

  def attendance_saved?
    context.attendance.persisted?
  end

  def create_game_night_attendance
    UserGameNightAttendance.create(user_id:       context.user_id,
                                   game_night_id: context.game_night_id)
  end
end
