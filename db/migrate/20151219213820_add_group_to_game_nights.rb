class AddGroupToGameNights < ActiveRecord::Migration
  def change
    add_reference :game_nights, :group, index: true, foreign_key: true
  end
end
