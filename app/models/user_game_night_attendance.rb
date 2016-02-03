class UserGameNightAttendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_night
end
