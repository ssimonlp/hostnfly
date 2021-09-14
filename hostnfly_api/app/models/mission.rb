class Mission < ApplicationRecord
  belongs_to :listing

  validates :date, presence: true

  def price
    listing.num_rooms * price_per_room
  end

  def simple_type
    model_name.element.titleize
  end
end
