class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.string   :password_digest
      t.boolean  :email_confirmed
      t.string   :confirm_digest
      t.string   :reset_digest
      t.datetime :reset_sent_at

      t.timestamps null: false
    end
  end
end
