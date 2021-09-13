class Listing < ApplicationRecord
  with_options dependent: :destroy do |association|
    association.has_many :bookings
    association.has_many :missions
    association.has_many :reservations
  end

  with_options foreign_key: :listing_id, inverse_of: :listing, dependent: :destroy do |association|
    association.has_many :first_checkins, class_name: 'Missions::FirstCheckin'
    association.has_many :last_checkouts, class_name: 'Missions::LastCheckout'
    association.has_many :checkout_checkins, class_name: 'Missions::CheckoutCheckin'
    association.has_many :active_bookings, -> { where(is_active: true) }, class_name: 'Booking'
    association.has_many :active_reservations, -> { where(is_active: true) }, class_name: 'Reservation'
  end

  validates :num_rooms, presence: true

  def booking_slots
    bookings.pluck(:start_date, :end_date)
  end
end
