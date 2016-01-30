class RemoveModeratorIdFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :moderator_id, :integer
  end
end
