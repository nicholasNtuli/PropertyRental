class ReviewSerializer < ActiveModel::Serializer
    include JSONAPI::Serializer

    attributes :id, :rating, :comment, :created_at

    attribute :user do |review|
        {
            id: review.user.id,
            full_name: review.user.full_name,
            avatar_url: review.user.avatar_url
        }
    end
end