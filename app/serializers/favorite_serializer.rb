class FavoriteSerializer < ActiveModel::Serializer
    include JSONAPI::Serializer

    attributes :id, :created_at

    attribute :property do |favorite|
        PropertySerializer.new(favorite.property).serializer_hash[:data][:attributes]
    end
end