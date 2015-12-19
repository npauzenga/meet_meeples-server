class Group < ActiveRecord::Base
  has_many :user_group_memberships
  has_many :users, through: :user_group_memberships

  has_many :game_nights

  belongs_to :moderator, class_name: :User, foreign_key: :moderator_id

  validates :name, presence: true
end
