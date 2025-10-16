class AmenitySerializer < ActiveModel::Serializer
    include JSONAPI::Serializer
    
    attributes :id, :name, :icon, :category
end