class Amenity < ApplicationRecord
    has_many :property_amenities, dependent: :destroy
    has_many :properties, through: :property_amenities

    validates :name, presence: true, uniqueness: true

    scope :by_category, ->(category) { where(category: category) }
end
