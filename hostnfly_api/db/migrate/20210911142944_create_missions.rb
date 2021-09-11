class CreateMissions < ActiveRecord::Migration[6.1]
  def change
    create_table :missions do |t|
      t.references :listing, null: false, foreign_key: true, index: true
      t.date :date
      t.string :type, null: false

      t.timestamps
    end
  end
end
