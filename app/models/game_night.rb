class GameNight < ActiveRecord::Base
  validates :time, presence: true
  validates :location_name, presence: true
end
