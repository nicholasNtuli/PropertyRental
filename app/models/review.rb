class Review < ApplicationRecord
  belongs_to :property, counter_cache: true
  belongs_to :user

  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :user_id, uniqueness: { scope: :property_id, message: 'has already reviewed this property' }

  after_save :update_property_rating
  after_destroy :update_property_rating

  private 

  def update_property_rating
    property.update_rating
  end
end
