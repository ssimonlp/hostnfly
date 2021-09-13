class Mission < ApplicationRecord
  belongs_to :listing

  validates :date, presence: true

  def simple_type
    model_name.element
  end
end
