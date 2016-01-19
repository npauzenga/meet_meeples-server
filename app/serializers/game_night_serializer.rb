class GameNightSerializer < ActiveModel::Serializer
  attributes :id, :time, :location_name, :location_address
end
