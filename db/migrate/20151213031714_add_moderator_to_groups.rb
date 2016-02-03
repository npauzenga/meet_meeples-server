class AddModeratorToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :moderator_id, :integer
  end
end
