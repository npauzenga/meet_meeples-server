class Group < ActiveRecord::Base
  has_many :user_group_memberships
  has_many :users, through: :user_group_memberships

  has_many :game_nights

  validates :name, presence: true
end
