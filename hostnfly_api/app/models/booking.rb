class Booking < ApplicationRecord
  belongs_to :listing

  validates :start_date,
            :end_date,
            :is_active,
            presence: true
end
