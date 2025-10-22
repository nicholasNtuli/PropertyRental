class Booking < ApplicationRecord
  enum :status, { pending: 0, confirmed: 1, cancelled: 2, completed: 3 }

  belongs_to :property
  belongs_to :user

  validates :check_in, :check_out, :total_price, presence: true
  validate :check_out_after_check_in
  validate :property_available

  scope :upcoming, -> { where('check_in > ?', Date.today).order(:check_in) }
  scope :past, -> { where('check_out < ?', Date.today).order(check_out: :desc) }
  scope :current, -> { where('check_in <= ? AND check_out >= ?', Date.today, Date.today) }

  def nights
    (check_out - check_in).to_i
  end

  def calculate_total_price
    return unless check_in && check_out && property

    self.total_price = nights * property.price_per_night
  end

  private

  def check_out_after_check_in
    return unless check_in && check_out

    if check_out <= check_in
      errors.add(:check_out, 'must be after check-in date')
    end
  end

  def property_available
    return unless property && check_in && check_out

    unless property.available_between?(check_in, check_out)
      errors.add(:base, 'Property is not available for the selected dates')
    end
  end
end