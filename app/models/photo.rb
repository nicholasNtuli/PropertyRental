class Photo < ApplicationRecord
  belongs_to :property

  validates :url, presence: true
  validates :position, numericality: { greater_than_or_equal_to: 0 }

  default_scope { order(position: :asc) }

  before_create :set_position

  private

  def set_position
    self.position ||= propertyz.photos.maximum(:position).to_i + 1
  end
end
