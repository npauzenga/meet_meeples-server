class AddOrganizerToGameNights < ActiveRecord::Migration
  def change
    add_column :game_nights, :organizer_id, :integer
  end
end
