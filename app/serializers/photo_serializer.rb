class PhotoSerializer < ActiveModel::Serializer
    attributes :id, :url, :cloudanry_url, :position, :is_primary, :property_id
end