class GameNightSerializer < ActiveModel::Serializer
  attributes :id, :name, :time, :location_name, :location_address
end
