class UserSerializer
    include JSONAPI::Serializer

    attributes :id, :email, :first_name, :last_name, :phone, :role, :avatar_url, :bio, :created_at

    attribute :full_name do |user|
        user.full_name
    end
end 