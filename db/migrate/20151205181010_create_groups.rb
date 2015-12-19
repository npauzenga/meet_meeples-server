class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.string :facebook
      t.string :twitter
      t.string :moderator_email

      t.timestamps null: false
    end
  end
end
