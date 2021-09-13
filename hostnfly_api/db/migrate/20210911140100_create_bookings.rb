class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :listing, null: false, foreign_key: true, index: true
      t.date :start_date
      t.date :end_date
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
