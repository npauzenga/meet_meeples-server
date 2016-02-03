class CreateUserGroupMemberships < ActiveRecord::Migration
  def change
    create_table :user_group_memberships do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
