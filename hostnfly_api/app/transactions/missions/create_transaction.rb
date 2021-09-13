module Missions
  class CreateTransaction < ::ApplicationTransaction
    include Dry::Transaction(container: ::LockableContainer)

    # transaction is surrounded by input[:resource].with_lock to be sure
    # that terms are created only once and at first error an ActiveRecord::Rollback
    # is raised
    around :lockable, with: 'lockable'

    tee :params
    step :generate_booking_missions
    step :generate_reservation_missions

    def params(input)
      @listing = input.fetch(:listing)
    end

    def generate_booking_missions(input)
      @listing.active_bookings.find_each do |booking|
        checkin = @listing.first_checkins.new(date: booking.start_date)
        checkout = @listing.last_checkouts.new(date: booking.end_date)

        checkin.extend(DateValidator).save!
        checkout.extend(DateValidator).save!
      rescue ActiveRecord::RecordInvalid => e
        Failure(input.merge(error: e))
      end
      Success(input)
    end

    def generate_reservation_missions(input)
      @listing.active_reservations.find_each do |reservation|
        next if @listing.last_checkouts.where(date: reservation.end_date).any?

        checkin_checkout = @listing.checkout_checkins.new(date: reservation.end_date)
        checkin_checkout.extend(DateValidator).save!

      rescue ActiveRecord::RecordInvalid => e
        Failure(input.merge(error: e))
      end
      Success(input)
    end
  end
end