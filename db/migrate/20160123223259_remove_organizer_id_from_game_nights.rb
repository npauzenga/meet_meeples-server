class RemoveOrganizerIdFromGameNights < ActiveRecord::Migration
  def change
    remove_column :game_nights, :organizer_id, :integer
  end
end
