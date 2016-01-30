class GameNight < ActiveRecord::Base
  validates :time, presence: true
  validates :location_name, presence: true

  belongs_to :group
  belongs_to :organizer, class_name: :User, foreign_key: :organizer_id

  has_many :user_game_night_attendances
  has_many :users, through: :user_game_night_attendances
end
