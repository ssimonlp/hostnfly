FactoryBot.define do
  factory :reservation do
    start_date { Date.today }
    end_date { Date.today + rand(5).days }
    listing
  end
end