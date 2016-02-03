class CreateUserGameNightAttendees < ActiveRecord::Migration
  def change
    create_table :user_game_night_attendees do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :game_night, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
