class BookingSerializer < ActiveModel::Serializer
    include JSONAPI::Serializer

    attributes :id, :check_in, :check_out, :total_price, :status,
               :guests_count, :special_requests, :created_at



    attribite :nights do |booking|
        booking.nights
    end

    attribute :property do |booking|
        {
            id: booking.property.id,
            title: booking.property.title,
            city: booking.property.city,
            price_per_night: booking.property.price_per_night,
            primary_photo: booking.property.primary_photo&.url
        }
    end

    attribute :user do |booking|
        {
            id: booking.user.id,
            full_name: booking.user.full_name,
            email: booking.user.email
        }
    end
end