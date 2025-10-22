class Property < ApplicationRecord
  # Enums
  enum :property_type, { cabin: 0, entire_home: 1, unique_stay: 2 }
  enum :status, { draft: 0, active: 1, inactive: 2, pending: 3 }

  # Associations
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :property_amenities, dependent: :destroy
  has_many :amenities, through: :property_amenities
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # Validations
  validates :title, presence: true, length: { minimum: 10, maximum: 100 }
  validates :description, presence: true, length: { minimum: 50 }
  validates :price_per_night, presence: true, numericality: { greater_than: 0 }
  validates :bedrooms, :bathrooms, :guests, presence: true, numericality: { greater_than: 0 }
  validates :city, :country, presence: true

  # Scopes
  scope :featured_properties, -> { where(featured: true, status: :active) }
  scope :active_properties, -> { where(status: :active) }
  scope :by_property_type, ->(type) { where(property_type: type) }
  scope :recent, -> { order(created_at: :desc) }
  scope :top_rated, -> { where('average_rating >= ?', 4.5).order(average_rating: :desc) }

  # Callbacks
  after_create :set_default_status

  # Methods
  def primary_photo
    photos.find_by(is_primary: true) || photos.first
  end

  def available_between?(check_in, check_out)
    !bookings.where(status: [:confirmed, :pending])
             .where('check_in < ? AND check_out > ?', check_out, check_in)
             .exists?
  end

  def update_rating
    return if reviews.empty?

    self.average_rating = reviews.average(:rating).round(2)
    self.reviews_count = reviews.count
    save
  end

  private
  def set_default_status
    update(status: :draft) if saved_change_to_status? == false && status.nil?
  end
end