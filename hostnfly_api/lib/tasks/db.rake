require "#{Rails.root}/lib/backend_test"

namespace :db do
  include DbData

  desc 'Custom db seed'

  task seed: :environment do
    input = DbData.input

    input[:listings].each do |listing_attributes|
      Listing.create!(listing_attributes)
    end

    input[:bookings].each do |booking_attributes|
      Booking.create!(booking_attributes)
    end

    input[:reservations].each do |reservation_attributes|
      Reservation.create!(reservation_attributes)
    end
  end
end
