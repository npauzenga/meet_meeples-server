class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :state, :country, :facebook, :twitter
end
