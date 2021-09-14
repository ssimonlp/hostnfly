FactoryBot.define do
  factory :mission do
    listing
    date { rand(10.months).months.from_now }

    factory :first_checkin_mission, class: 'Missions::FirstCheckin', parent: :mission do
      date { rand(2.months).months.from_now }
    end
    factory :last_checkout_mission, class: 'Missions::LastCheckout', parent: :mission do
      date { rand(5.months).months.from_now }
    end
    factory :checkout_checkin_mission, class: 'Missions::CheckoutCheckin', parent: :mission do
      date { rand(3.months).months.from_now }
    end
  end
end