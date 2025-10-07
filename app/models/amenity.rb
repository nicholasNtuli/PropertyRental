class Amenity < ApplicationRecord
    has_many :properties_amenities, dependent: :destroy
    has_many :properties, through: :properties_amenities
    
    validates :name, presence: true, uniqueness: true

    scope :by_category, ->(category) { where(category: category) }
end
