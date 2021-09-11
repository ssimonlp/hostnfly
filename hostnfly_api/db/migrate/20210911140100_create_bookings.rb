class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :listing, null: false, foreign_key: true, index: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.boolean :is_active, null: false

      t.timestamps
    end
  end
end
