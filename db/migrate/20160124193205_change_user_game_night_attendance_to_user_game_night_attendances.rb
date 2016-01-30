class ChangeUserGameNightAttendanceToUserGameNightAttendances < ActiveRecord::Migration
  def change
    rename_table :user_game_night_attendance, :user_game_night_attendances
  end
end
