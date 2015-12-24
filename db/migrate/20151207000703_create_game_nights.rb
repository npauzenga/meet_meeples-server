class CreateGameNights < ActiveRecord::Migration
  def change
    create_table :game_nights do |t|
      t.datetime :time
      t.string :location_name
      t.string :location_address

      t.timestamps null: false
    end
  end
end
