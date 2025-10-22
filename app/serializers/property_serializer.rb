class PropertySerializer
    include JSONAPI::Serializer
    
    attributes :id, :title, :description, :location, :city, :country,
               :latitude, :longitude, :price_per_night, :property_type,
               :bedrooms, :bathrooms, :guests, :status, :featured,
               :average_rating, :review_count, :created_at

    attribute :primary_photo do |property|
        photo = property.primary_photo
        photo ? { 
                    id: photo.id, 
                    url: photo.url 
                } : nil
    end

    attribute :photos do |property, params|
        if params && params[:detailed]
            property.photos.map do |photo|
                { 
                    id: photo.id, 
                    url: photo.url, 
                    cloudinary_id: photo.cloudinary_id,
                    is_primary: photo.is_primary
                }
            end
        end
    end

    attribute :amenities do |property, params|
        if params && params[:detailed]
            property.amenities.map do |amenity|
                { 
                    id: amenity.id, 
                    name: amenity.name,
                    icon: amenity.icon,
                    category: amenity.category
                }
            end
        end
    end

    attribute :owner do |property, params|
        if params && params[:include_user] || params[:detailed]
            {
                id: property.user.id,
                full_name: property.user.full_name,
                avatar_url: property.user.avatar_url
            }
        end
    end

    attribute :review_summary do |property, params|
        if params && params[:detailed]
            {
                average_rating: property.average_rating,
                total_reviews: property.reviews_count,
                rating_distribution: property.reviews.group(:rating).count
            }
        end
    end

    attribute :review_count do |property|
        property.reviews.size
    end
end