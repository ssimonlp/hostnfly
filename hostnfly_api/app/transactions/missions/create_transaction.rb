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
        @listing.first_checkins.create!(date: booking.start_date)
        @listing.last_checkouts.create!(date: booking.end_date)

      rescue ActiveRecord::RecordInvalid => e
        Failure(input.merge(error: e))
      end
      Success(input)
    end

    def generate_reservation_missions(input)
      @listing.active_reservations.find_each do |reservation|
        next if @listing.last_checkouts.where(date: reservation.end_date).any?

        @listing.checkout_checkins.create!(date: reservation.end_date)

      rescue ActiveRecord::RecordInvalid => e
        Failure(input.merge(error: e))
      end
      Success(input)
    end
  end
end