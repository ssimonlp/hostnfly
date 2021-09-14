FactoryBot.define do
  factory :listing do
    num_rooms { rand(10) }

    trait :with_bookings do
      after(:create) do |listing|
        5.times do |i|
          listing.bookings.create(
            start_date: Date.today + i.months,
            end_date: Date.today + 10.days + i.months
          )
        end
      end
    end

    trait :with_reservations do
      after(:create) do |listing|
        5.times do |i|
          listing.reservations.create(
            start_date: Date.today + i.months,
            end_date: Date.today + rand(1..10).days + i.months
          )
        end
      end
    end

    factory :complete_listing do
      with_bookings
      with_reservations
    end
  end
end
