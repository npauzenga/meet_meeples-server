class AddNameToGameNights < ActiveRecord::Migration
  def change
    add_column :game_nights, :name, :string
  end
end
