class Reservation < ApplicationRecord
  belongs_to :listing

  validates :start_date,
            :end_date,
            :is_active,
            presence: true
  validate :in_booking_range?

  private

  def in_booking_range?
    unless listing.booking_slots.map do |slot|
      (slot.first..slot.last).include?(start_date..end_date)
    end.any?

      %i[start_date end_date].each do |attribute|
        errors.add(
          attribute,
          :invalid_date
        )
      end
    end
  end

  def reservation_overlaping?
    if listing
        .active_reservations
        .where(
          'DATE(reservations.start_date) < DATE(?) AND DATE(reservations.end_date) > DATE(?)',
          end_date,
          start_date
        ).any?

      errors.add(
        :start_date,
        :must_not_overlap
      )
    end
  end
end
