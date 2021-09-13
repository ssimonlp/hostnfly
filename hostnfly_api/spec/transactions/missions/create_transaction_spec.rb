require 'rails_helper'

RSpec.describe Missions::CreateTransaction do
  subject { described_class.call(resource: listing) }

  describe 'for a listing with several reservations' do
    let(:listing) { create(:complete_listing, num_rooms: 5) }

    it 'generates one first checkin per active booking' do
      expect { subject }.to(
        change(listing.first_checkins, :count)
        .from(0)
        .to(listing.active_bookings.count)
      )
    end

    it 'generates one last checkout per active booking' do
      expect { subject }.to(
        change(listing.last_checkouts, :count)
        .from(0)
        .to(listing.active_bookings.count)
      )
    end

    it 'generates new checkout_checkins' do
      expect { subject }.to(
        change(listing.checkout_checkins, :count)
      )
    end

    it 'does not generate a checkout checkin if a last checkout is already planned' do
      subject
      last_checkout_dates = listing.last_checkouts.pluck(:date)
      expect(listing.checkout_checkins.where(date: last_checkout_dates)).to be_empty
    end
  end

  describe 'for a listing with no reservations' do
    let(:listing) { create(:listing, :with_bookings, num_rooms: 5) }

    it 'does not generate any checkout_checkin' do
      subject
      expect(listing.checkout_checkins).to be_empty
    end
  end

  describe 'when validations fails' do
    let(:listing) { create(:listing) }
    let(:booking) do
      create(
        :booking,
        listing_id: listing.id,
        start_date: Date.today,
        end_date: Date.today + 1.days
      )
    end
    let(:reservation) do
      create(
        :reservation,
        listing_id: listing.id,
        start_date: Date.today + 1.days,
        end_date: Date.today + 2.days
      )

      it 'rollbacks everything if an error occurs' do
        expect_any_instance_of(Reservation).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)
        expect(subject).to be_failure
        expect(listing.reload.missions.count).to eq(0)
      end
    end
  end
end
