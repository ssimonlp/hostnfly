# Guidelines
1. Clone this repo (do not fork it)
2. Commit your code as you do it
3. Once you are done, contact us!

# Backend test

We are building a listing rentals management company; let’s call it Hostnfly ;)
4 main object populate our app :
- listings : apartments of our clients
- bookings : periods of time during which our clients leave us their apartment
- reservations : periods of time during which a guest rents one of our apartments
- mission : cleaning an apartment

bookings, reservations and missions all BELONG to listing (they all have a listing_id) but are not otherwise directly related to one another.

Here is our plan to clean the apartment :
- We create a cleaning mission called ‘first_checkin’ at the beginning of the booking
- We create a cleaning mission called ‘last_checkout’ before the owner comes back
- We create a cleaning mission called ‘checkout_checkin’ at the end of each reservation UNLESS there is already a last_checkout at the same date

We negotiated the prices with our cleaning partner :
- a first checkin costs 10€ per room
- a checkout checkin costs 10€ per room
- a last_checkout costs 5€ per room

Here is  the input json
```
{
  "listings": [
    { "id": 1, "num_rooms": 2 },
    { "id": 2, "num_rooms": 1 },
    { "id": 3, "num_rooms": 3 }
  ],
  "bookings": [
    { "id": 1, "listing_id": 1, "start_date": "2016-10-10", "end_date": "2016-10-15" },
    { "id": 2, "listing_id": 1, "start_date": "2016-10-16", "end_date": "2016-10-20" },
    { "id": 3, "listing_id": 2, "start_date": "2016-10-15", "end_date": "2016-10-20" }
  ],
  "reservations": [
    { "id": 1, "listing_id": 1, "start_date": "2016-10-11", "end_date": "2016-10-13" },
    { "id": 1, "listing_id": 1, "start_date": "2016-10-13", "end_date": "2016-10-15" },
    { "id": 1, "listing_id": 1, "start_date": "2016-10-16", "end_date": "2016-10-20" },
    { "id": 3, "listing_id": 2, "start_date": "2016-10-15", "end_date": "2016-10-18" }
  ]
}
```

We need to generate a JSON of all the mission and their mission_type, date, and price

The output JSON should resemble this
```
{
  "missions": [
    {:listing_id=>1, :mission_type=>"first_checkin", :date=>"2016-10-10", :price=>20},
    {:listing_id=>1, :mission_type=>"last_checkout", :date=>"2016-10-15", :price=>10},
    {:listing_id=>1, :mission_type=>"first_checkin", :date=>"2016-10-16", :price=>20},
    {:listing_id=>1, :mission_type=>"last_checkout", :date=>"2016-10-20", :price=>10},
    {:listing_id=>1, :mission_type=>"checkout_checkin", :date=>"2016-10-13", :price=>20},
    {:listing_id=>2, :mission_type=>"first_checkin", :date=>"2016-10-15", :price=>10},
    {:listing_id=>2, :mission_type=>"last_checkout", :date=>"2016-10-20", :price=>5},
    {:listing_id=>2, :mission_type=>"checkout_checkin", :date=>"2016-10-18", :price=>10}
  ]
}
```
Go slowly, and write code that could be easily extensible and clean.
