class Reservation < ApplicationRecord
  belongs_to :listing

  validates :start_date,
            :end_date,
            :is_active,
            presence: true
  validate :in_booking_range?

  private

  def in_booking_range?
    listing.booking_slots.map do |slot|
      (slot.start_date..slot.end_date).include?(start_date..end_date)
    end.any?
  end
end
