require 'rails_helper'

RSpec.describe Missions::CreateTransaction do
  subject { described_class.call(listing: listing) }

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

    it 'generates one checkout_checkin per active reservation' do
      expect { subject }.to(
        change(listing.checkout_checkins, :count)
        .from(0)
        .to(listing.active_reservations.count)
      )
    end
  end
end
