class Listing < ApplicationRecord
  with_options dependent: destroy do |association|
    association.has_many :bookings
    association.has_many :listings
    association.has_many :reservations
  end
end
