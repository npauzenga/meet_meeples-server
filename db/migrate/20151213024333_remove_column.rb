class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :groups, :moderator_email
  end
end
