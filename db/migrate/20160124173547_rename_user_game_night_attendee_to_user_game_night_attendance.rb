class RenameUserGameNightAttendeeToUserGameNightAttendance < ActiveRecord::Migration
  def change
    rename_table :user_game_night_attendees, :user_game_night_attendance
  end
end
